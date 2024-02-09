import Foundation
import Combine
import CoreData
import Network

class DailyZenViewModel: ObservableObject {
    @Published var dailyZenDetails: [DailyZenDetail]?
    @Published var currentDayDiff = 0
    @Published var showLoader = false
    @Published var isOnline = true
    @Published var isDataAvailable = true
    private let monitor = NWPathMonitor()
    
    private let networkService = NetworkService()
    private var cancellables: Set<AnyCancellable> = []
    var context: NSManagedObjectContext
    
    init() {
        self.context = PersistenceStore(inMemory: false).context
    }
    
    func fetchDataPreviousDate() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        if currentDayDiff < 6, isDataAvailable,
           let previousDate = calendar.date(
            byAdding: .day,
            value: -1 * (currentDayDiff + 1),
            to: currentDate) {
            fetchData(date: previousDate)
            currentDayDiff += 1
        }
    }
    
    func fetchDataNextDate() {
        let currentDate = Date()
        let calendar = Calendar.current
        isDataAvailable = true
        
        if currentDayDiff > 0,
           let previousDate = calendar.date(
            byAdding: .day,
            value: -1 * (currentDayDiff - 1),
            to: currentDate) {
            fetchData(date: previousDate)
            currentDayDiff -= 1
        }
    }
    
    func fetchData(date: Date) {
        let fDate = getFormatted(date)
        guard let url = URL(string: "\(networkService.baseUrl)?date=\(fDate)&version=2") else { return }
        
        let localData = fetchLocalData(dateString: fDate)
        
        if (localData.count > 0) {
            self.dailyZenDetails = localData
        } else if isOnline {
            self.showLoader = true
            networkService.fetchData(from: url)
                .sink(receiveCompletion: { [weak self] completion in
                    self?.showLoader = false
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }, receiveValue: { [weak self] response in
                    self?.dailyZenDetails = response
                    self?.createNewDailyZenItem(details: response ?? [], dateString: fDate, dateShowed: date)
                })
                .store(in: &cancellables)
        } else {
            isDataAvailable = false
            currentDayDiff -= 1
        }
    }
    
    func getFormatted(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: date)
    }
    
    func createNewDailyZenItem(details: [DailyZenDetail], dateString: String, dateShowed: Date) {
        var index: Int16 = 0
        details.forEach { detail in
            let dailyZenDetailMo = DailyZenDetailMo(context: context)
            dailyZenDetailMo.text = detail.text
            dailyZenDetailMo.author = detail.author
            dailyZenDetailMo.dateString = dateString
            dailyZenDetailMo.uniqueId = detail.uniqueId
            dailyZenDetailMo.dzType = detail.dzType
            dailyZenDetailMo.themeTitle = detail.themeTitle
            dailyZenDetailMo.articleUrl = detail.articleUrl
            dailyZenDetailMo.dzImageUrl = detail.dzImageUrl
            dailyZenDetailMo.primaryCTAText = detail.primaryCTAText
            dailyZenDetailMo.sharePrefix = detail.sharePrefix
            dailyZenDetailMo.dateShowed = dateShowed
            dailyZenDetailMo.orderIndex = index
            index += 1
        }
        
        try? context.save()
    }
    
    func fetchLocalData(dateString: String) -> [DailyZenDetail] {
        var details: [DailyZenDetail] = []
        let fetchRequest: NSFetchRequest<DailyZenDetailMo> = DailyZenDetailMo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "dateString = %@", dateString)
        
        if let objects = try? context.fetch(fetchRequest) {
            details = objects.map {
                return DailyZenDetail(dailyZenDetailMo: $0)
            }
        }
        details = details.sorted {
            if let orderIndex0 = $0.orderIndex, let orderIndex1 = $1.orderIndex {
                return orderIndex0 < orderIndex1
            } else {
                return $0.text < $1.text
            }
        }
        return details
    }

    func deleteOlderEntities() {
        let fetchRequest: NSFetchRequest<DailyZenDetailMo> = DailyZenDetailMo.fetchRequest()
        if let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -6, to: Date()) as? NSDate {
            fetchRequest.predicate = NSPredicate(format: "dateShowed < %@", sevenDaysAgo as NSDate)

            do {
                let result = try context.fetch(fetchRequest)
                
                for object in result {
                    context.delete(object)
                }
                
                try context.save()
                
                print("Entities older than 7 days deleted successfully")
            } catch {
                print("Error deleting entities older than 7 days: \(error.localizedDescription)")
            }
        }
    }

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                if let isOnline = self?.isOnline, !isOnline, path.status == .satisfied {
                    self?.isDataAvailable = true
                }
                self?.isOnline = path.status == .satisfied
            }
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
