//
//  GreaterThanOrEqualRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A rule that requires a non-`nil` value to be greater than or equal to a fixed reference value.
///
/// # Example
///
/// ```swift
/// enum ValidationError: Error {
///     case tooSmall
/// }
///
/// let rule = GreaterThanOrEqualRule(10, error: ValidationError.tooSmall)
/// try rule.validate(10)
/// ```
public struct GreaterThanOrEqualRule<Value: Comparable>: FormFieldRule {

    // MARK: - Private Properties

    private let value: Value
    private let error: any Error

    // MARK: - Initializer

    /// Creates an inclusive greater-than rule with a fixed reference value.
    public init(_ value: Value, error: any Error) {
        self.value = value
        self.error = error
    }

    // MARK: - Public Methods

    /// Validates that the supplied value is greater than or equal to the reference value. A `nil` value passes.
    public func validate(_ value: Value?) throws {
        guard let value else { return }

        if value < self.value {
            throw error
        }
    }

}
