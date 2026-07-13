//
//  MaxLengthRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A rule that requires a measurable value not to exceed a maximum length.
///
/// # Example
///
/// ```swift
/// enum ValidationError: Error {
///     case tooLong
/// }
///
/// let rule = MaxLengthRule(5, error: ValidationError.tooLong)
/// try rule.validate("Swift")
/// ```
public struct MaxLengthRule: FormFieldRule {

    // MARK: - Public Properties

    /// The existential value type accepted by the rule.
    public typealias Value = any Mensurable

    // MARK: - Private Properties

    private let referenceValue: Value
    private let error: any Error

    // MARK: - Initializer

    /// Creates a maximum-length rule from a measurable reference value.
    public init(_ referenceValue: Value, error: any Error) {
        self.referenceValue = referenceValue
        self.error = error
    }

    // MARK: - Public Methods

    /// Validates that the supplied measure does not exceed the reference measure. A `nil` value passes.
    public func validate(_ value: Value?) throws {
        guard let value else { return }

        if value.length > referenceValue.length {
            throw error
        }
    }

}
