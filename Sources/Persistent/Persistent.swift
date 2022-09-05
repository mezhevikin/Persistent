// Mezhevikin Alexey: https://github.com/mezhevikin/persistent
import Foundation
import Combine

@propertyWrapper
public struct Persistent<Value> {
    private let key: String
    private var value: Value
    private let defaultValue: Value
    private var container: UserDefaults = .standard
    private let publisher = PassthroughSubject<Value, Never>()
    
    public init(
        _ key: String,
        _ defaultValue: Value,
        _ container: UserDefaults = .standard
    ) {
        self.key = key
        self.value = container.object(forKey: key) as? Value ?? defaultValue
        self.defaultValue = defaultValue
        self.container = container
    }
    
    public var wrappedValue: Value {
        get { value }
        set {
            value = newValue
            if let optional = value as? AnyOptional, optional.isNil {
                container.removeObject(forKey: key)
            } else {
                container.set(value, forKey: key)
            }
            publisher.send(value)
        }
    }

    public var projectedValue: AnyPublisher<Value, Never> {
        publisher.eraseToAnyPublisher()
    }
}

public protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}

extension Persistent where Value: ExpressibleByNilLiteral {
    public init(_ key: String, _ container: UserDefaults = .standard) {
        self.init(key, nil, container)
    }
}

extension UserDefaults {
    public func clear() {
        for key in dictionaryRepresentation().keys {
            removeObject(forKey: key)
        }
    }
}
