import Foundation
import MicroClient

public enum PostsAPIFactory {

    /// Add a bookmark.
    public static func addRequest(
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
            parameters: [
                "url": url.absoluteString,
                "description": description,
                "extended": extended,
                "tags": tags,
                "dt": date.map(DateFormatter.defaultAPIFormatter.string),
                "replace": replace,
                "shared": shared,
                "toread": toread
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
            parameters: [
                "url": url.absoluteString
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
            parameters: [
                "rat": tag,
                "dt": date.map(DateFormatter.defaultAPIFormatter.string),
                "url": url?.absoluteString,
                "meta": meta
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
            parameters: [
                "tag": tag
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
            parameters: [
                "tag": tag,
                "count": count.map(String.init)
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
            parameters: [
                "tag": tag,
                "start": start.map(String.init),
                "results": results.map(String.init),
                "fromdt": fromDate.map(DateFormatter.defaultAPIFormatter.string),
                "todt": toDate.map(DateFormatter.defaultAPIFormatter.string),
                "meta": meta.map(String.init)
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
            parameters: [
                "url": url.absoluteString
            ]
        )
    }
}
