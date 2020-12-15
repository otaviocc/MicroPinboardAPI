import Foundation

public struct PinboardAPI {

    // MARK: - Properties

    let networkClient: PinboardClient

    private let authToken: (() -> String?)

    // MARK: - Life cycle

    public init(
        userToken: @escaping (() -> String?)
    ) {
        self.authToken = userToken
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
            host: "api.pinboard.in",
            path: path,
            queryItems: queryItems,
            authToken: authToken
        )
    }
}
