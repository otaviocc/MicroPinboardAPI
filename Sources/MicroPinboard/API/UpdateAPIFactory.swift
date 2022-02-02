import Foundation
import MicroClient

public enum UpdateAPIFactory {

    /// Returns the most recent time a bookmark was added, updated or deleted.
    /// Use this before calling posts/all to see if the data has changed since
    /// the last fetch.
    public static func makeUpdateRequest() -> NetworkRequest<VoidRequest, UpdateResponse> {
        .init(path: "/v1/posts/update", method: .get)
    }
}
