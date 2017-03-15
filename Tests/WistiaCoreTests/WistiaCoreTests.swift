import XCTest
@testable import WistiaCore

class WistiaCoreTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(WistiaCore().text, "Hello, World!")
    }


    static var allTests : [(String, (WistiaCoreTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
