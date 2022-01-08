import Foundation
import MicroClient

public enum PinboardAPI {

    /// Returns a full list of the user's tags along with the number of
    /// times they were used.
    public static func makeGetRequest(
    ) -> NetworkRequest<VoidRequest, TagsGetResponse> {
        .init(
            path: "/v1/tags/get",
            method: .get
        )
    }

    /// Delete an existing tag.
    public static func makeDeleteRequest(
        tag: String
    ) -> NetworkRequest<VoidRequest, GenericResponse> {
        .init(
            path: "/v1/tags/delete",
            method: .get,
            parameters: [
                "tag": tag
            ]
        )
    }

    /// Rename a tag, or fold it in to an existing tag.
    public static func makeRenameRequest(
        old: String,
        new: String
    ) -> NetworkRequest<VoidRequest, GenericResponse> {
        .init(
            path: "/v1/tags/rename",
            method: .get,
            parameters: [
                "old": old,
                "new": new
            ]
        )
    }
}
