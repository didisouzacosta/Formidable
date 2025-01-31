//
//  LessThanOrEqualRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A validation rule that ensures a given value is less than or equal to a reference value.
///
/// This rule checks whether the input value is **less than or equal to** a specified reference value.
/// If the input value is greater, the specified error is thrown.
///
/// # Example
/// ```swift
/// let rule = LessThanOrEqualRule(10, error: ValidationError.tooLarge)
/// do {
///     try rule.validate(5)  // ✅ Valid (5 ≤ 10)
///     try rule.validate(15) // ❌ Throws ValidationError.tooLarge
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// # Notes
/// - If the value is `nil`, validation passes automatically.
/// - This rule ensures **less than or equal to** (`≤`), not strictly less than (`<`).
/// - Can be used for numeric types or any type conforming to `Comparable`.
public struct LessThanOrEqualRule<Value: Comparable>: FormFieldRule {
    
    // MARK: - Private Properties
    
    private let value: Value
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that ensures a value is less than or equal to a reference value.
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
    
    /// Validates that the given value is less than or equal to the reference value.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value is greater than the reference value.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        if value > self.value {
            throw error
        }
    }
    
}

