import Foundation

public struct PinboardAPI {

    // MARK: - Properties

    let networkClient: PinboardClient
    let apiDateFormatter: DateFormatter

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
