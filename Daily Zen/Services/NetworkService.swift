import Foundation
import Combine

class NetworkService {
    private let session: URLSession
    
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
