import Foundation
import Combine

class DailyZenViewModel: ObservableObject {
    private let networkService = NetworkService()
    private var cancellables: Set<AnyCancellable> = []
    @Published var dailyZenDetails: [DailyZenDetail]?
    
    init() { }
    
    func fetchData() {
        guard let url = URL(string: "https://m67m0xe4oj.execute-api.us-east-1.amazonaws.com/prod/dailyzen/?date=\(20230930)&version=2") else { return }
        
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
                print(response)
            })
            .store(in: &cancellables)
    }
}
