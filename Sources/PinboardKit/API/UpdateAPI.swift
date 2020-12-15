import Foundation
import Combine

public protocol UpdateAPI {

    /// Returns the most recent time a bookmark was added, updated or deleted.
    /// Use this before calling posts/all to see if the data has changed since
    /// the last fetch.
    func update(
    ) -> AnyPublisher<UpdateResponse, Error>
}

// MARK: - UpdateAPI

extension PinboardAPI: UpdateAPI {

    // MARK: - Public

    public func update(
    ) -> AnyPublisher<UpdateResponse, Error> {
        networkClient
            .run(makeUpdateRequest())
            .map(\.value)
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private func makeUpdateRequest(
    ) -> URLRequest {
        makeURLRequest(
            path: "/v1/posts/update"
        )
    }
}
