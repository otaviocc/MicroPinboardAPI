import Foundation
import MicroClient

public protocol PinboardAPIFactoryProtocol {

    func makePinboardAPIClient(
        userToken: @escaping () -> String?
    ) -> NetworkClientProtocol
}

public struct PinboardAPIFactory: PinboardAPIFactoryProtocol {

    // MARK: - Life cycle

    public init() {}

    // MARK: - Public

    public func makePinboardAPIClient(
        userToken: @escaping () -> String?
    ) -> NetworkClientProtocol {
        let configuration = PinboardAPIFactory.makeAPIConfiguration()

        configuration.interceptor = { request in
            guard let url = request.url else {
                return request
            }

            var components = URLComponents(
                url: url,
                resolvingAgainstBaseURL: true
            )

            components?.queryItems?.append(
                URLQueryItem(name: "format", value: "json")
            )

            if let token = userToken() {
                components?.queryItems?.append(
                    URLQueryItem(name: "auth_token", value: token)
                )
            }

            guard let newURL = components?.url else {
                return request
            }

            return URLRequest(url: newURL)
        }

        return NetworkClient(
            configuration: configuration
        )
    }

    // MARK: - Private

    private static func makeAPIConfiguration(
    ) -> NetworkConfiguration {
        .init(
            session: .shared,
            defaultDecoder: .defaultJSONDecoder,
            defaultEncoder: JSONEncoder(),
            baseURL: URL(string: "api.pinboard.in")!
        )
    }
}
