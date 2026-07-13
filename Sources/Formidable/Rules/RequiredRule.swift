//
//  RequiredRule.swift
//  Formidable
//
//  Created by Adriano Costa on 14/01/25.
//

/// A rule that requires a value to be non-`nil` and nonempty.
///
/// # Example
///
/// ```swift
/// enum ValidationError: Error {
///     case required
/// }
///
/// let rule = RequiredRule(ValidationError.required)
/// try rule.validate("Formidable")
/// ```
public struct RequiredRule: FormFieldRule {

    // MARK: - Public Properties

    /// The existential value type accepted by the rule.
    public typealias T = any Emptable

    // MARK: - Private Properties

    private let error: any Error

    // MARK: - Initializer

    /// Creates a required-value rule.
    ///
    /// - Parameter error: The error thrown for `nil` or empty values.
    public init(_ error: any Error) {
        self.error = error
    }

    // MARK: - Public Methods

    /// Validates that the value exists and is not empty.
    public func validate(_ value: T?) throws {
        guard let value, !value.isEmpty else {
            throw error
        }
    }

}
