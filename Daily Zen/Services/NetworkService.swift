import Foundation
import Combine

class NetworkService {
    private let session: URLSession
    let baseUrl = "https://m67m0xe4oj.execute-api.us-east-1.amazonaws.com/prod/dailyzen/"
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 30
        session = URLSession(configuration: configuration)
    }
    
    func fetchData<T: Decodable>(from url: URL) -> AnyPublisher<T, Error> {
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
