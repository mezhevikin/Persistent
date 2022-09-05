import XCTest
@testable import Persistent

extension UserDefaults {
    
    @Persistent("login", .standard)
    static var login: String?
    
    @Persistent("isDarkMode", false)
    static var isDarkMode: Bool
}

final class PersistentTests: XCTestCase {
    override func setUp() {
        UserDefaults.standard.clear()
    }
    
    func testChange() throws {
        UserDefaults.login = "mezhevikin"
        XCTAssertEqual(UserDefaults.login, "mezhevikin")
        XCTAssertEqual(UserDefaults.standard.string(forKey: "login"), "mezhevikin")
        UserDefaults.login = nil
        XCTAssertNil(UserDefaults.login)
        XCTAssertNil(UserDefaults.standard.string(forKey: "login"))
    }
    
    func testCombine() throws {
        XCTAssertEqual(UserDefaults.isDarkMode, false)
        let subscription = UserDefaults.$isDarkMode.sink {
            XCTAssertEqual($0, true)
        }
        UserDefaults.isDarkMode = true
        subscription.cancel()
    }
}
