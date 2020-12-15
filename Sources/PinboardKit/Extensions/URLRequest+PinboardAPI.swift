import Foundation

extension URLRequest {

    /// Builds a Pinboard URLRequest. It appends the auth token and
    /// json format.
    static func makeURLRequest(
        path: String,
        queryItems: [URLQueryItem] = [],
        authToken: @escaping (() -> String?)
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
        components.host = "api.pinboard.in"
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
        request.httpMethod = "GET"
        return request
    }
}
