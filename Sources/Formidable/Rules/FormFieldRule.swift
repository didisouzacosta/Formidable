//
//  FormFieldRule.swift
//  Formidable
//
//  Created by Adriano Costa on 13/01/25.
//

/// A validation rule for an optional field value.
///
/// Rules may treat `nil` as valid or invalid according to their specific contract and throw the configured error
/// when validation fails.
///
/// # Example
///
/// ```swift
/// struct AlwaysValidRule: FormFieldRule {
///     func validate(_ value: String?) throws {}
/// }
/// ```
public protocol FormFieldRule {

    /// The value accepted by the rule.
    associatedtype Value

    /// Validates an optional value.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: A rule-specific error when validation fails.
    func validate(_ value: Value?) throws

}
