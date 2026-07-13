//
//  EqualKeyPathRule.swift
//  Formidable
//
//  Created by Adriano Costa on 04/02/25.
//

/// A rule that requires a value to equal a reference value read through a key path.
///
/// # Example
///
/// ```swift
/// enum ValidationError: Error {
///     case mismatch
/// }
///
/// final class Credentials {
///     var password = "secret"
/// }
///
/// let credentials = Credentials()
/// let rule = EqualKeyPathRule(credentials, keyPath: \.password, error: ValidationError.mismatch)
/// try rule.validate("secret")
/// ```
public struct EqualKeyPathRule<Root, Value: Equatable>: FormFieldRule {

    // MARK: - Public Properties

    /// A transformation of the reference value before comparison.
    public typealias Transform = (Value) -> Value
    /// An optional transformation applied to the current reference value.
    public var transform: Transform?

    // MARK: - Private Properties

    private let root: Root
    private let keyPath: KeyPath<Root, Value>
    private let error: any Error

    // MARK: - Initializer

    /// Creates an equality rule backed by a key path.
    public init(
        _ root: Root,
        keyPath: KeyPath<Root, Value>,
        error: any Error,
        transform: Transform? = nil
    ) {
        self.root = root
        self.keyPath = keyPath
        self.error = error
        self.transform = transform
    }

    // MARK: - Public Methods

    /// Validates equality with the current transformed reference value. A `nil` value passes.
    public func validate(_ value: Value?) throws {
        guard let value else { return }

        let referenceValue = root[keyPath: keyPath]
        let transformedValue = transform?(referenceValue) ?? referenceValue

        if transformedValue != value {
            throw error
        }
    }

}
