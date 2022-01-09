import XCTest
import PinboardKit

class TagsAPIFactoryTests: XCTestCase {

    func testMakeGetRequest() throws {
        let request = TagsAPIFactory.makeGetRequest()

        XCTAssertEqual(
            request.path, "/v1/tags/get"
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertNil(request.body)
        XCTAssertNil(request.decoder)
        XCTAssertNil(request.encoder)
    }

    func testMakeDeleteRequest() throws {
        let request = TagsAPIFactory.makeDeleteRequest(
            tag: "foobar"
        )

        XCTAssertEqual(
            request.path, "/v1/tags/delete"
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "tag", value: "foobar")
                )
            )
        )

        XCTAssertNil(request.body)
        XCTAssertNil(request.decoder)
        XCTAssertNil(request.encoder)
    }

    func testMakeRenameRequest() throws {
        let request = TagsAPIFactory.makeRenameRequest(
            old: "old_name",
            new: "new_name"
        )

        XCTAssertEqual(
            request.path, "/v1/tags/rename"
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "new", value: "new_name")
                )
            )
        )

        XCTAssertTrue(
            try XCTUnwrap(
                request.queryItems?.contains(
                    URLQueryItem(name: "old", value: "old_name")
                )
            )
        )

        XCTAssertNil(request.body)
        XCTAssertNil(request.decoder)
        XCTAssertNil(request.encoder)
    }
}
