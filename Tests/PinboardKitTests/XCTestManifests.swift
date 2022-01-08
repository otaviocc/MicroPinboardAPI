import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    [testCase(PinboardKitTests.allTests)]
}
#endif
