//
//  LessThanRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A rule that requires a non-`nil` value to be strictly less than a fixed reference value.
///
/// # Example
///
/// ```swift
/// enum ValidationError: Error {
///     case tooLarge
/// }
///
/// let rule = LessThanRule(10, error: ValidationError.tooLarge)
/// try rule.validate(9)
/// ```
public struct LessThanRule<Value: Comparable>: FormFieldRule {

    // MARK: - Private Properties

    private let value: Value
    private let error: any Error

    // MARK: - Initializer

    /// Creates a strict less-than rule with a fixed reference value.
    public init(_ value: Value, error: any Error) {
        self.value = value
        self.error = error
    }

    // MARK: - Public Methods

    /// Validates that the supplied value is strictly less than the reference value. A `nil` value passes.
    public func validate(_ value: Value?) throws {
        guard let value else { return }

        if value >= self.value {
            throw error
        }
    }

}
