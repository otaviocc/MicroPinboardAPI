import Foundation

public struct PinboardAPI {

    // MARK: - Properties

    let networkClient: PinboardClient

    private let host: String = "api.pinboard.in"
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
        method: String,
        path: String,
        queryItems: [URLQueryItem] = []
    ) -> URLRequest {
        let token = URLQueryItem(
            name: "auth_token",
            value: authToken()
        )

        let format = URLQueryItem(
            name: "format",
            value: "json"
        )

        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = queryItems
        components.queryItems?.append(
            contentsOf: [token, format]
        )

        guard
            let url = components.url
        else {
            fatalError("Error building the URL")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
