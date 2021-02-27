import Foundation
import Combine

public struct PinboardAPI {

    // MARK: - Properties

    let networkClient: PinboardClient
    let apiDateFormatter: DateFormatter

    private var cancellables: Set<AnyCancellable> = []
    private let authToken: (() -> String?)

    // MARK: - Life cycle

    public init(
        userToken: @escaping (() -> String?)
    ) {
        self.authToken = userToken
        self.apiDateFormatter = .defaultAPIFormatter
        self.networkClient = PinboardClient(
            session: .shared,
            decoder: .defaultJSONDecoder
        )
    }

    public func eventPublisher(
    ) -> AnyPublisher<PinboardAPIEvent, Never> {
        networkClient.eventPublisher()
            .map { event in
                switch event {
                case .loading:
                    return .loading
                case .finishedLoading:
                    return .finishedLoading
                case .errorLoading:
                    return .errorLoading
                }
            }
            .eraseToAnyPublisher()
    }
}

extension PinboardAPI {

    func makeURLRequest(
        path: String,
        queryItems: [URLQueryItem] = []
    ) -> URLRequest {
        .makeURLRequest(
            path: path,
            queryItems: queryItems,
            authToken: authToken
        )
    }
}
