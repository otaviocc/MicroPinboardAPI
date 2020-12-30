import Foundation
import Combine

public protocol PostsAPI {

    /// Add a bookmark.
    func add(
        url: URL,
        description: String,
        extended: String?,
        tags: String?,
        date: Date?,
        replace: String?,
        shared: String?,
        toread: String?
    ) -> AnyPublisher<GenericResponse, Error>

    /// Delete a bookmark.
    func delete(
        url: URL
    ) -> AnyPublisher<GenericResponse, Error>

    /// Returns one or more posts on a single day matching the arguments.
    func get(
        tag: String?,
        date: Date?,
        url: URL?,
        meta: String?
    ) -> AnyPublisher<RecentResponse, Error>

    /// Returns a list of dates with the number of posts at each date.
    func dates(
        tag: String?
    ) -> AnyPublisher<DatesResponse, Error>

    /// Returns a list of the user's most recent posts, filtered by tag.
    func recents(
        tag: String?,
        count: Int?
    ) -> AnyPublisher<RecentResponse, Error>

    /// Returns all bookmarks in the user's account.
    func all(
        tag: String?,
        start: Int?,
        results: Int?,
        fromDate: Date?,
        toDate: Date?,
        meta: Int?
    ) -> AnyPublisher<[PostResponse], Error>

    /// Returns a list of popular tags and recommended tags for a given URL.
    func suggest(
        url: URL
    ) -> AnyPublisher<SuggestResponse, Error>
}

extension PinboardAPI: PostsAPI {

    // MARK: - Public

    public func add(
        url: URL,
        description: String,
        extended: String? = nil,
        tags: String? = nil,
        date: Date? = nil,
        replace: String? = nil,
        shared: String? = nil,
        toread: String? = nil
    ) -> AnyPublisher<GenericResponse, Error> {
        networkClient
            .run(
                makeAddRequest(
                    url: url,
                    description: description,
                    extended: extended,
                    tags: tags,
                    date: date,
                    replace: replace,
                    shared: shared,
                    toread: toread
                )
            )
            .map(\.value)
            .eraseToAnyPublisher()
    }

    public func delete(
        url: URL
    ) -> AnyPublisher<GenericResponse, Error> {
        networkClient
            .run(makeDeleteRequest(url: url))
            .map(\.value)
            .eraseToAnyPublisher()
    }

    public func get(
        tag: String? = nil,
        date: Date? = nil,
        url: URL? = nil,
        meta: String? = nil
    ) -> AnyPublisher<RecentResponse, Error> {
        networkClient
            .run(
                makeGetRequest(
                    tag: tag,
                    date: date,
                    url: url,
                    meta: meta
                )
            )
            .map(\.value)
            .eraseToAnyPublisher()
    }

    public func dates(
        tag: String? = nil
    ) -> AnyPublisher<DatesResponse, Error>  {
        networkClient
            .run(makeDatesRequest(tag: tag))
            .map(\.value)
            .eraseToAnyPublisher()
    }

    public func recents(
        tag: String? = nil,
        count: Int? = nil
    ) -> AnyPublisher<RecentResponse, Error> {
        networkClient
            .run(makeRecentRequest(tag: tag, count: count))
            .map(\.value)
            .eraseToAnyPublisher()
    }

    public func all(
        tag: String? = nil,
        start: Int? = nil,
        results: Int? = nil,
        fromDate: Date? = nil,
        toDate: Date? = nil,
        meta: Int? = nil
    ) -> AnyPublisher<[PostResponse], Error> {
        networkClient
            .run(
                makeAllRequest(
                    tag: tag,
                    start: start,
                    results: results,
                    fromDate: fromDate,
                    toDate: toDate,
                    meta: meta
                )
            )
            .map(\.value)
            .eraseToAnyPublisher()
    }

    public func suggest(
        url: URL
    ) -> AnyPublisher<SuggestResponse, Error> {
        networkClient
            .run(makeSuggestRequest(url: url))
            .map(\.value)
            .eraseToAnyPublisher()
    }

    // MARK: - Private

    private func makeAddRequest(
        url: URL,
        description: String,
        extended: String? = nil,
        tags: String? = nil,
        date: Date? = nil,
        replace: String? = nil,
        shared: String? = nil,
        toread: String? = nil
    ) -> URLRequest {
        makeURLRequest(
            path: "/v1/posts/add",
            queryItems: [
                URLQueryItem(name: "url", value: url.absoluteString),
                URLQueryItem(name: "description", value: description),
                URLQueryItem(name: "extended", value: extended),
                URLQueryItem(name: "tags", value: tags),
                URLQueryItem(
                    name: "dt",
                    value: date.map(apiDateFormatter.string(from:))
                ),
                URLQueryItem(name: "replace", value: replace),
                URLQueryItem(name: "shared", value: shared),
                URLQueryItem(name: "toread", value: toread)
            ]
        )
    }

    private func makeDeleteRequest(
        url: URL
    ) -> URLRequest {
        makeURLRequest(
            path: "/v1/posts/delete",
            queryItems: [
                URLQueryItem(name: "url", value: url.absoluteString)
            ]
        )
    }

    private func makeGetRequest(
        tag: String? = nil,
        date: Date? = nil,
        url: URL? = nil,
        meta: String? = nil
    ) -> URLRequest {
        makeURLRequest(
            path: "/v1/posts/get",
            queryItems: [
                URLQueryItem(name: "tag", value: tag),
                URLQueryItem(
                    name: "dt",
                    value: date.map(apiDateFormatter.string(from:))
                ),
                URLQueryItem(name: "url", value: url?.absoluteString),
                URLQueryItem(name: "meta", value: meta)
            ]
        )
    }

    private func makeDatesRequest(
        tag: String? = nil
    ) -> URLRequest {
        makeURLRequest(
            path: "/v1/posts/dates",
            queryItems: [
                URLQueryItem(name: "tag", value: tag)
            ]
        )
    }

    private func makeRecentRequest(
        tag: String? = nil,
        count: Int? = nil
    ) -> URLRequest {
        makeURLRequest(
            path: "/v1/posts/recent",
            queryItems: [
                URLQueryItem(name: "tag", value: tag),
                URLQueryItem(name: "count", value: count.map(String.init))
            ]
        )
    }

    private func makeAllRequest(
        tag: String? = nil,
        start: Int? = nil,
        results: Int? = nil,
        fromDate: Date? = nil,
        toDate: Date? = nil,
        meta: Int? = nil
    ) -> URLRequest {
        makeURLRequest(
            path: "/v1/posts/all",
            queryItems: [
                URLQueryItem(name: "tag", value: tag),
                URLQueryItem(name: "start", value: start.map(String.init)),
                URLQueryItem(name: "results", value: results.map(String.init)),
                URLQueryItem(
                    name: "fromdt",
                    value: fromDate.map(apiDateFormatter.string(from:))
                ),
                URLQueryItem(
                    name: "todt",
                    value: toDate.map(apiDateFormatter.string(from:))
                ),
                URLQueryItem(name: "meta", value: meta.map(String.init))
            ]
        )
    }

    private func makeSuggestRequest(
        url: URL
    ) -> URLRequest {
        makeURLRequest(
            path: "/v1/posts/suggest",
            queryItems: [
                URLQueryItem(name: "url", value: url.absoluteString)
            ]
        )
    }
}
