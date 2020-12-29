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
    private let eventSubject =
        PassthroughSubject<PinboardClientEvent, Never>()

    // MARK: - Life cycle

    init(
        session: URLSession,
        decoder: JSONDecoder
    ) {
        self.session = session
        self.decoder = decoder
    }

    // MARK: - Public

    public func eventPublisher(
    ) -> AnyPublisher<PinboardClientEvent, Never> {
        eventSubject
            .eraseToAnyPublisher()
    }

    func run<T: Decodable>(
        _ request: URLRequest
    ) -> AnyPublisher<Response<T>, Error> {
        eventSubject.send(.loading)

        return session
            .dataTaskPublisher(for: request)
            .tryMap { result in
                eventSubject.send(.finishedLoading)

                return Response(
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
