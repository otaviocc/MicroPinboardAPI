import Combine
import Foundation

struct PinboardClient {

    // MARK: - Nested types

    struct Response<T> {
        public let value: T
        public let response: URLResponse
    }

    // MARK: - Properties

    private let session: URLSession
    private let decoder: JSONDecoder

    // MARK: - Life cycle

    init(
        session: URLSession,
        decoder: JSONDecoder
    ) {
        self.session = session
        self.decoder = decoder
    }

    // MARK: - Public

    func run<T: Decodable>(
        _ request: URLRequest
    ) -> AnyPublisher<Response<T>, Error> {
        session
            .dataTaskPublisher(for: request)
            .tryMap { result in
                Response(
                    value: try decoder.decode(
                        T.self,
                        from: result.data
                    ),
                    response: result.response
                )
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
