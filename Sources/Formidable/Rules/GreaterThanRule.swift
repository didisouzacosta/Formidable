//
//  GreaterThanRule.swift
//  Formidable
//
//  Created by Adriano Costa on 14/01/25.
//

/// A rule that requires a non-`nil` value to be strictly greater than a fixed reference value.
///
/// # Example
///
/// ```swift
/// enum ValidationError: Error {
///     case tooSmall
/// }
///
/// let rule = GreaterThanRule(10, error: ValidationError.tooSmall)
/// try rule.validate(11)
/// ```
public struct GreaterThanRule<Value: Comparable>: FormFieldRule {

    // MARK: - Private Properties

    private let value: Value
    private let error: any Error

    // MARK: - Initializer

    /// Creates a strict greater-than rule with a fixed reference value.
    public init(_ value: Value, error: any Error) {
        self.value = value
        self.error = error
    }

    // MARK: - Public Methods

    /// Validates that the supplied value is strictly greater than the reference value. A `nil` value passes.
    public func validate(_ value: Value?) throws {
        guard let value else { return }

        if value <= self.value {
            throw error
        }
    }

}
