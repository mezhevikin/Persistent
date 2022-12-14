⚙️ A tiny property wrapper for UserDefaults. Only 60 lines of code. 

```swift
import Persistent

extension UserDefaults {
    
    // Optional property
    @Persistent("login", .standard)
    static var login: String?
    
    // Property with default value
    @Persistent("isDarkMode", false)
    static var isDarkMode: Bool
}
```

```swift
UserDefaults.login = "mezhevikin"
UserDefaults.isDarkMode = true
```

### Combine
```swift
let subscription = UserDefaults.$isDarkMode.sink {
    print($0)
}
UserDefaults.isDarkMode = true
```

### Swift Package Manager
```
https://github.com/mezhevikin/persistent.git
```

Inspired [Antonie Van Der Lee](https://www.avanderlee.com/swift/property-wrappers/)
