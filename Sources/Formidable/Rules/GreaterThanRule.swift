//
//  GreaterThanRule.swift
//  Formidable
//
//  Created by Adriano Costa on 14/01/25.
//

/// A validation rule that ensures a given value is greater than a reference value.
///
/// This rule checks whether the input value is **greater than** a specified reference value.
/// If the input value is less than or equal to the reference value, the specified error is thrown.
///
/// # Example
/// ```swift
/// let rule = GreaterThanRule(10, error: ValidationError.tooSmall)
/// do {
///     try rule.validate(15) // ✅ Valid (15 > 10)
///     try rule.validate(5) // ❌ Throws ValidationError.tooSmall
///     try rule.validate(10) // ❌ Throws ValidationError.tooSmall
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// # Notes
/// - If the value is `nil`, validation passes automatically.
/// - This rule ensures **greater than** (`>`) comparison, not greater than or equal to (`≥`).
/// - Can be used for numeric types or any type conforming to `Comparable`.
public struct GreaterThanRule<Value: Comparable>: FormFieldRule {
    
    // MARK: - Private Properties
    
    private let value: Value
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that ensures a value is greater than a reference value.
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
    
    /// Validates that the given value is greater than the reference value.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value is less than or equal to the reference value.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        if value < self.value {
            throw error
        }
    }
    
}



