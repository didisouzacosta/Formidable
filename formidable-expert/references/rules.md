# Formidable Rule Creation Guide

## Core Protocol: FormFieldRule

Every rule must conform to `FormFieldRule`:

```swift
public protocol FormFieldRule {
    associatedtype Value
    func validate(_ value: Value?) throws
}
```

## Pattern 1: Static Rules

For comparisons with fixed values.

- **Naming**: `[Action]Rule` (e.g., `RequiredRule`, `MinLengthRule`).
- **Implementation**: Receives the expected value and the error in the `init`.

```swift
public struct MyStaticRule: FormFieldRule {
    public typealias Value = Int
    private let limit: Int
    private let error: Error

    public init(_ limit: Int, error: Error) {
        self.limit = limit
        self.error = error
    }

    public func validate(_ value: Value?) throws {
        guard let value, value > limit else { throw error }
    }
}
```

## Pattern 2: KeyPath Rules

For cross-field validation.

- **Naming**: `[Action]KeyPathRule` (e.g., `EqualKeyPathRule`).
- **Implementation**: Receives a `root` and a `KeyPath`.

```swift
public struct MyKeyPathRule<Root, Value: Equatable>: FormFieldRule {
    private let root: Root
    private let keyPath: KeyPath<Root, Value>
    private let error: Error

    public init(_ root: Root, keyPath: KeyPath<Root, Value>, error: Error) {
        self.root = root
        self.keyPath = keyPath
        self.error = error
    }

    public func validate(_ value: Value?) throws {
        guard let value else { return }
        let referenceValue = root[keyPath: keyPath]
        if value != referenceValue { throw error }
    }
}
```

## Type Erasure with AnyRule

Always use `AnyRule` when adding rules to a `FormField`'s `rules` list to erase generic types:

```swift
field.rules = [AnyRule(RequiredRule(error)), AnyRule(MyKeyPathRule(form, keyPath: \.otherField, error: error))]
```
