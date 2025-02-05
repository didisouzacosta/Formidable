//
//  LessThanRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

import Foundation

/// A validation rule that ensures a given value is strictly less than a reference value.
///
/// This rule compares the input value against a predefined reference value.
/// If the input value is **greater than or equal to** the reference value, the specified error is thrown.
///
/// # Example
/// ```swift
/// let rule = LessThanRule(10, error: ValidationError.tooLarge)
/// do {
///     try rule.validate(8) // ✅ Valid (8 < 10)
///     try rule.validate(12) // ❌ Throws ValidationError.tooLarge
///     try rule.validate(10) // ❌ Throws ValidationError.tooLarge
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// # Notes
/// - If `value` is `nil`, the validation passes automatically.
/// - The rule ensures **strictly less than** (`<`), not less than or equal (`≤`).
/// - Can be used for numbers, dates, or any type conforming to `Comparable`.
public struct LessThanRule<Value: Comparable>: FormFieldRule {
    
    // MARK: - Private Properties
    
    private let value: Value
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that validates whether a value is strictly less than the specified reference.
    ///
    /// - Parameters:
    ///   - value: The reference value to compare against.
    ///   - error: The error to throw if validation fails.
    public init(
        _ value: Value,
        error: Error
    ) {
        self.value = value
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates that the given value is strictly less than the reference value.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value is greater than or equal to the reference.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        if value >= self.value {
            throw error
        }
    }
    
}

