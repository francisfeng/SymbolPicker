    import XCTest
    @testable import SymbolPicker
    
    final class SymbolPickerTests: XCTestCase {
      func testExample() {
        XCTAssertNotNil(SymbolPicker.makeNewWindow())
        XCTAssertEqual(SymbolPicker().text, "Hello, World!")
      }
    }
