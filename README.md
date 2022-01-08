# PinboardKit

PinboardKit is a [Pinboard](https://pinboard.in) [API](https://pinboard.in/api) wrapper, written in Swift using async/wait.

```swift
public protocol PinboardAPIFactoryProtocol {
    func makePinboardAPIClient(
        userToken: @escaping () -> String?
    ) -> NetworkClientProtocol
}
```

The network client takes a single parameter: `userToken: @escaping () -> String?`, where the user token is passed to the client and is dynamically evaluated when needed (useful in those case where the network client is initialized before the user is asked to provide the token).

```swift
let factory = PinboardAPIFactory()

let client = factory.makePinboardAPIClient {
    "A_VALID_TOKEN_GOES_HERE"
}
```

Network requests are also built by factories, returning strongly-typed request objects:

```swift
// NetworkRequest<VoidRequest, DatesResponse>
let recentsRequest = PostsAPIFactory.makeDatesRequest()
```

The network client takes a single parameter, the `request`, returning `NetworkResponse`

```swift
public protocol NetworkClientProtocol {
    func run<RequestModel, ResponseModel>(
        _ networkRequest: NetworkRequest<RequestModel, ResponseModel>
    ) async throws -> NetworkResponse<ResponseModel>
}
```

E.g.:

```swift
let recentsRequest = PostsAPIFactory.makeRecentRequest()
let recentsResponse = try await client.run(recentsRequest)
```
