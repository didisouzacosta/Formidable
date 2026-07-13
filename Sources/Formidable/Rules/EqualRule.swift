//
//  EqualRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A rule that requires a non-`nil` value to equal a fixed reference value.
///
/// # Example
///
/// ```swift
/// enum ValidationError: Error {
///     case mismatch
/// }
///
/// let rule = EqualRule("confirmation", error: ValidationError.mismatch)
/// try rule.validate("confirmation")
/// ```
public struct EqualRule<Value: Equatable>: FormFieldRule {

    // MARK: - Private Properties

    private let value: Value
    private let error: any Error

    // MARK: - Initializer

    /// Creates an equality rule with a fixed reference value.
    public init(_ value: Value, error: any Error) {
        self.value = value
        self.error = error
    }

    // MARK: - Public Methods

    /// Validates equality with the reference value. A `nil` value passes.
    public func validate(_ value: Value?) throws {
        guard let value else { return }

        if self.value != value {
            throw error
        }
    }

}
