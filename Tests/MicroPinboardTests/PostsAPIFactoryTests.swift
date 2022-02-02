import XCTest
import MicroPinboard

class PostsAPIFactoryTests: XCTestCase {

    func testMakeAddRequestBasic() throws {
        let request = PostsAPIFactory.makeAddRequest(
            url: URL(string: "http://some.fake.url")!,
            description: "some description"
        )

        XCTAssertEqual(
            request.path, "/v1/posts/add"
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "url", value: "http://some.fake.url")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "description", value: "some description")
                )
            )
        )

        XCTAssertNil(request.body)
        XCTAssertNil(request.decoder)
        XCTAssertNil(request.encoder)
    }

    func testMakeAddRequestComplete() throws {
        let request = PostsAPIFactory.makeAddRequest(
            url: URL(string: "http://some.fake.url")!,
            description: "some description",
            extended: "some extended info",
            tags: "tag0 tag1 tag2",
            date: .distantFuture,
            replace: "replace?",
            shared: "yes",
            toread: "no"
        )

        XCTAssertEqual(
            request.path, "/v1/posts/add"
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertEqual(
            request.queryItems?.count,
            8
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "url", value: "http://some.fake.url")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "description", value: "some description")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "extended", value: "some extended info")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "tags", value: "tag0 tag1 tag2")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "replace", value: "replace?")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "shared", value: "yes")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "toread", value: "no")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "dt", value: "4001-01-01")
                )
            )
        )

        XCTAssertNil(request.body)
        XCTAssertNil(request.decoder)
        XCTAssertNil(request.encoder)
    }

    func testMakeDeleteRequest() throws {
        let request = PostsAPIFactory.makeDeleteRequest(
            url: URL(string: "http://some.fake.url")!
        )

        XCTAssertEqual(
            request.path, "/v1/posts/delete"
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "url", value: "http://some.fake.url")
                )
            )
        )

        XCTAssertNil(request.body)
        XCTAssertNil(request.decoder)
        XCTAssertNil(request.encoder)
    }

    func testMakeGetRequestBasic() throws {
        let request = PostsAPIFactory.makeGetRequest()

        XCTAssertEqual(
            request.path, "/v1/posts/get"
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertNil(request.body)
        XCTAssertNil(request.decoder)
        XCTAssertNil(request.encoder)
    }

    func testMakeGetRequestComplete() throws {
        let request = PostsAPIFactory.makeGetRequest(
            tag: "tag1",
            date: .distantFuture,
            url: URL(string: "http://some.fake.url")!,
            meta: "some meta"
        )

        XCTAssertEqual(
            request.path, "/v1/posts/get"
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertEqual(
            request.queryItems?.count,
            4
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "tag", value: "tag1")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "url", value: "http://some.fake.url")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "dt", value: "4001-01-01")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "meta", value: "some meta")
                )
            )
        )

        XCTAssertNil(request.body)
        XCTAssertNil(request.decoder)
        XCTAssertNil(request.encoder)
    }

    func testMakeDatesRequest() throws {
        let request = PostsAPIFactory.makeDatesRequest(
            tag: "tag1"
        )

        XCTAssertEqual(
            request.path, "/v1/posts/dates"
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertEqual(
            request.queryItems?.count,
            1
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "tag", value: "tag1")
                )
            )
        )

        XCTAssertNil(request.body)
        XCTAssertNil(request.decoder)
        XCTAssertNil(request.encoder)
    }

    func testMakeRecentRequestBasic() throws {
        let request = PostsAPIFactory.makeRecentRequest()

        XCTAssertEqual(
            request.path, "/v1/posts/recent"
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertNil(request.body)
        XCTAssertNil(request.decoder)
        XCTAssertNil(request.encoder)
    }

    func testMakeRecentRequestComplete() throws {
        let request = PostsAPIFactory.makeRecentRequest(
            tag: "tag1",
            count: 10
        )

        XCTAssertEqual(
            request.path, "/v1/posts/recent"
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertEqual(
            request.queryItems?.count,
            2
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "tag", value: "tag1")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "count", value: "10")
                )
            )
        )

        XCTAssertNil(request.body)
        XCTAssertNil(request.decoder)
        XCTAssertNil(request.encoder)
    }

    func testMakeAllRequestBasic() throws {
        let request = PostsAPIFactory.makeAllRequest()

        XCTAssertEqual(
            request.path, "/v1/posts/all"
        )

        XCTAssertEqual(
            request.method,
            .get
        )
    }

    func testMakeAllRequestComplete() throws {
        let request = PostsAPIFactory.makeAllRequest(
            tag: "tag1",
            start: 10,
            results: 20,
            fromDate: .distantPast,
            toDate: .distantFuture,
            meta: 15
        )

        XCTAssertEqual(
            request.path, "/v1/posts/all"
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertEqual(
            request.queryItems?.count,
            6
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "tag", value: "tag1")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "start", value: "10")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "results", value: "20")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "fromdt", value: "0000-01-01")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "todt", value: "4001-01-01")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "meta", value: "15")
                )
            )
        )

        XCTAssertNil(request.body)
        XCTAssertNil(request.decoder)
        XCTAssertNil(request.encoder)
    }

    func testMakeSuggestRequest() throws {
        let request = PostsAPIFactory.makeSuggestRequest(
            url: URL(string: "http://some.fake.url")!
        )

        XCTAssertEqual(
            request.path, "/v1/posts/suggest"
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "url", value: "http://some.fake.url")
                )
            )
        )

        XCTAssertNil(request.body)
        XCTAssertNil(request.decoder)
        XCTAssertNil(request.encoder)
    }
}
