import XCTest
import PinboardKit

final class UpdateAPIFactoryTests: XCTestCase {

    func testMakeUpdateRequest() throws {
        let request = UpdateAPIFactory.makeUpdateRequest()

        XCTAssertEqual(
            request.path, "/v1/posts/update"
        )

        XCTAssertEqual(
            request.method,
            .get
        )

        XCTAssertNil(request.body)
        XCTAssertNil(request.decoder)
        XCTAssertNil(request.encoder)
    }
}
