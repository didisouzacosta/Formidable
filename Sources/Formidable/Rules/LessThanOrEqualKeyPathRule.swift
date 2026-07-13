//
//  LessThanOrEqualKeyPathRule.swift
//  Formidable
//
//  Created by Adriano Costa on 04/02/25.
//

/// A rule that requires a value to be less than or equal to a reference value read through a key path.
///
/// # Example
///
/// ```swift
/// enum ValidationError: Error {
///     case tooLarge
/// }
///
/// final class Limits {
///     var maximum = 10
/// }
///
/// let limits = Limits()
/// let rule = LessThanOrEqualKeyPathRule(limits, keyPath: \.maximum, error: ValidationError.tooLarge)
/// try rule.validate(10)
/// ```
public struct LessThanOrEqualKeyPathRule<Root, Value: Comparable>: FormFieldRule {

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

    /// Creates an inclusive less-than rule backed by a key path.
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

    /// Validates that the supplied value is less than or equal to the transformed reference value.
    public func validate(_ value: Value?) throws {
        guard let value else { return }

        let referenceValue = root[keyPath: keyPath]
        let transformedValue = transform?(referenceValue) ?? referenceValue

        if value > transformedValue {
            throw error
        }
    }

}
