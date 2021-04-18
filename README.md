# PinboardKit

PinboardKit is a [Pinboard](https://pinboard.in) [API](https://pinboard.in/api) wrapper, written in Swift using Combine. The main object is `PinboardAPI`, and it can be initialized by passing an optional auth token. The token will be evaluated when building the request.

```swift
let apiClient = PinboardAPI {
    "USER:TOKEN"
}
```

Using the wrapper is straight-forward:

```swift
var cancellables = Set<AnyCancellable>()

apiClient
    .recentsPublisher()               // <- Publisher
    .sink(
        receiveCompletion: { _ in },
        receiveValue: { print($0) }
    )
    .store(in: &cancellables)
```

## Publishers

```swift
public protocol PostsAPI {

    /// Add a bookmark.
    func addPublisher(
        url: URL,
        description: String,
        extended: String?,
        tags: String?,
        dt: Date?,
        replace: String?,
        shared: String?,
        toread: String?
    ) -> AnyPublisher<GenericResponse, Error>

    /// Delete a bookmark.
    func deletePublisher(
        url: URL
    ) -> AnyPublisher<GenericResponse, Error>

    /// Returns one or more posts on a single day matching the arguments.
    func getPublisher(
        tag: String?,
        dt: Date?,
        url: URL?,
        meta: String?
    ) -> AnyPublisher<RecentResponse, Error>

    /// Returns a list of dates with the number of posts at each date.
    func datesPublisher(
        tag: String?
    ) -> AnyPublisher<DatesResponse, Error>

    /// Returns a list of the user's most recent posts, filtered by tag.
    func recentsPublisher(
        tag: String?,
        count: Int?
    ) -> AnyPublisher<RecentResponse, Error>

    /// Returns all bookmarks in the user's account.
    func allPublisher(
        tag: String?,
        start: Int?,
        results: Int?,
        fromdt: Date?,
        todt: Date?,
        meta: Int?
    ) -> AnyPublisher<RecentResponse, Error>

    /// Returns a list of popular tags and recommended tags for a given URL.
    func suggestPublisher(
        url: URL
    ) -> AnyPublisher<SuggestResponse, Error>
}
```

```swift
public protocol TagsAPI {

    /// Returns a full list of the user's tags along with the number of
    /// times they were used.
    func getPublisher(
    ) -> AnyPublisher<TagsGetResponse, Error>

    /// Delete an existing tag.
    func deletePublisher(
        tag: String
    ) -> AnyPublisher<GenericResponse, Error>

    /// Rename a tag, or fold it in to an existing tag.
    func renamePublisher(
        old: String,
        new: String
    ) -> AnyPublisher<GenericResponse, Error>
}
```

```swift
public protocol UpdateAPI {

    /// Returns the most recent time a bookmark was added, updated or deleted.
    /// Use this before calling posts/all to see if the data has changed since
    /// the last fetch.
    func updatePublisher(
    ) -> AnyPublisher<UpdateResponse, Error>
}
```
