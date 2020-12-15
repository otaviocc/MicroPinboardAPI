import Foundation
import Combine

public protocol TagsAPI {

    /// Returns a full list of the user's tags along with the number of
    /// times they were used.
    func get(
    ) -> AnyPublisher<TagsGetResponse, Error>

    /// Delete an existing tag.
    func delete(
        tag: String
    ) -> AnyPublisher<GenericResponse, Error>

    /// Rename a tag, or fold it in to an existing tag.
    func rename(
        old: String,
        new: String
    ) -> AnyPublisher<GenericResponse, Error>
}

extension PinboardAPI: TagsAPI {

    // MARK: - Public

    public func get(
    ) -> AnyPublisher<TagsGetResponse, Error> {
        networkClient
            .run(makeGetRequest())
            .map(\.value)
            .eraseToAnyPublisher()
    }

    public func delete(
        tag: String
    ) -> AnyPublisher<GenericResponse, Error> {
        networkClient
            .run(makeDeleteRequest(tag: tag))
            .map(\.value)
            .eraseToAnyPublisher()
    }

    public func rename(
        old: String,
        new: String
    ) -> AnyPublisher<GenericResponse, Error> {
        networkClient
            .run(makeRenameRequest(old: old, new: new))
            .map(\.value)
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private func makeGetRequest(
    ) -> URLRequest {
        makeURLRequest(
            path: "/v1/tags/get"
        )
    }

    private func makeDeleteRequest(
        tag: String
    ) -> URLRequest {
        makeURLRequest(
            path: "/v1/tags/delete",
            queryItems: [
                URLQueryItem(name: "tag", value: tag)
            ]
        )
    }

    private func makeRenameRequest(
        old: String,
        new: String
    ) -> URLRequest {
        makeURLRequest(
            path: "/v1/tags/rename",
            queryItems: [
                URLQueryItem(name: "old", value: old),
                URLQueryItem(name: "new", value: new)
            ]
        )
    }
}
