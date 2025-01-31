//
//  MaxLengthRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A validation rule that ensures a given value does not exceed a maximum length.
///
/// This rule checks whether the length of the input value is **less than or equal to** a specified maximum.
/// If the input value exceeds this length, the specified error is thrown.
///
/// # Example
/// ```swift
/// let rule = MaxLengthRule(in: 10, error: ValidationError.tooLong)
/// do {
///     try rule.validate(8)  // ✅ Valid (8 ≤ 10)
///     try rule.validate(12) // ❌ Throws ValidationError.tooLong
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// # Notes
/// - If `value` is `nil`, validation passes automatically.
/// - This rule ensures **less than or equal to** (`≤`), not strictly less than (`<`).
/// - Can be used for strings, arrays, or any type conforming to `Mensurable`.
public struct MaxLengthRule: FormFieldRule {
    
    public typealias Value = Mensurable
    
    // MARK: - Private Properties
    
    private let value: Value
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that validates whether a value does not exceed the maximum allowed length.
    ///
    /// - Parameters:
    ///   - value: The maximum length allowed.
    ///   - error: The error to throw if validation fails.
    public init(in value: Value, error: Error) {
        self.value = value
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates that the given value does not exceed the maximum length.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value exceeds the maximum allowed length.
    public func validate(_ value: Value?) throws {
        if self.value.length < (value?.length ?? 0) {
            throw error
        }
    }
    
}






