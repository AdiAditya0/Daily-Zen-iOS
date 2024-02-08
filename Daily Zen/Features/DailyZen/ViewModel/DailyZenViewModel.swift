import Foundation
import Combine
import CoreData

class DailyZenViewModel: ObservableObject {
    @Published var dailyZenDetails: [DailyZenDetail]?
    @Published var currentDayDiff = 0
    
    private let networkService = NetworkService()
    private var cancellables: Set<AnyCancellable> = []
    var context: NSManagedObjectContext
    
    init() {
        self.context = PersistenceStore(inMemory: false).context
    }
    
    func fetchDataPreviousDate() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        if currentDayDiff < 6,
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
        } else {
            networkService.fetchData(from: url)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }, receiveValue: { [weak self] response in
                    self?.dailyZenDetails = response
                    self?.createNewDailyZenItem(details: response ?? [], dateString: fDate)
                })
                .store(in: &cancellables)
        }
    }
    
    func getFormatted(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.string(from: date)
    }
    
    func createNewDailyZenItem(details: [DailyZenDetail], dateString: String) {
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
        
        return details
    }
}
