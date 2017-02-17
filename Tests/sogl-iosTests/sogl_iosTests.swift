import XCTest
@testable import sogl_ios

class sogl_iosTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(sogl_ios().text, "Hello, World!")
    }


    static var allTests : [(String, (sogl_iosTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
