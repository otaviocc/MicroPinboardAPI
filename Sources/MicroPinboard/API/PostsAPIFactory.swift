import Foundation
import MicroClient

public enum PostsAPIFactory {

    /// Add a bookmark.
    public static func makeAddRequest(
        url: URL,
        description: String,
        extended: String? = nil,
        tags: String? = nil,
        date: Date? = nil,
        replace: String? = nil,
        shared: String? = nil,
        toread: String? = nil
    ) -> NetworkRequest<VoidRequest, GenericResponse> {
        .init(
            path: "/v1/posts/add",
            method: .get,
            queryItems: [
                .init(name: "url", value: url.absoluteString),
                .init(name: "description", value: description),
                .init(name: "extended", value: extended),
                .init(name: "tags", value: tags),
                .init(name: "dt", value: date.map(DateFormatter.defaultAPIFormatter.string)),
                .init(name: "replace", value: replace),
                .init(name: "shared", value: shared),
                .init(name: "toread", value: toread)
            ]
        )
    }

    /// Delete a bookmark.
    public static func makeDeleteRequest(
        url: URL
    ) -> NetworkRequest<VoidRequest, GenericResponse> {
        .init(
            path: "/v1/posts/delete",
            method: .get,
            queryItems: [
                .init(name: "url", value: url.absoluteString)
            ]
        )
    }

    /// Returns one or more posts on a single day matching the arguments.
    public static func makeGetRequest(
        tag: String? = nil,
        date: Date? = nil,
        url: URL? = nil,
        meta: String? = nil
    ) -> NetworkRequest<VoidRequest, RecentResponse> {
        .init(
            path: "/v1/posts/get",
            method: .get,
            queryItems: [
                .init(name: "tag", value: tag),
                .init(name: "dt", value: date.map(DateFormatter.defaultAPIFormatter.string)),
                .init(name: "url", value: url?.absoluteString),
                .init(name: "meta", value: meta)
            ]
        )
    }

    /// Returns a list of dates with the number of posts at each date.
    public static func makeDatesRequest(
        tag: String? = nil
    ) -> NetworkRequest<VoidRequest, DatesResponse> {
        .init(
            path: "/v1/posts/dates",
            method: .get,
            queryItems: [
                .init(name: "tag", value: tag)
            ]
        )
    }

    /// Returns a list of the user's most recent posts, filtered by tag.
    public static func makeRecentRequest(
        tag: String? = nil,
        count: Int? = nil
    ) -> NetworkRequest<VoidRequest, RecentResponse> {
        .init(
            path: "/v1/posts/recent",
            method: .get,
            queryItems: [
                .init(name: "tag", value: tag),
                .init(name: "count", value: count.map(String.init))
            ]
        )
    }

    /// Returns all bookmarks in the user's account.
    public static func makeAllRequest(
        tag: String? = nil,
        start: Int? = nil,
        results: Int? = nil,
        fromDate: Date? = nil,
        toDate: Date? = nil,
        meta: Int? = nil
    ) -> NetworkRequest<VoidRequest, [PostResponse]> {
        .init(
            path: "/v1/posts/all",
            method: .get,
            queryItems: [
                .init(name: "tag", value: tag),
                .init(name: "start", value: start.map(String.init)),
                .init(name: "results", value: results.map(String.init)),
                .init(name: "fromdt", value: fromDate.map(DateFormatter.defaultAPIFormatter.string)),
                .init(name: "todt", value: toDate.map(DateFormatter.defaultAPIFormatter.string)),
                .init(name: "meta", value: meta.map(String.init)),
            ]
        )
    }

    /// Returns a list of popular tags and recommended tags for a given URL.
    public static func makeSuggestRequest(
        url: URL
    ) -> NetworkRequest<VoidRequest, SuggestResponse> {
        .init(
            path: "/v1/posts/suggest",
            method: .get,
            queryItems: [
                .init(name: "url", value: url.absoluteString)
            ]
        )
    }
}
