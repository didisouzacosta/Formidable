//
//  MinLengthRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A validation rule that ensures a given value meets a minimum length requirement.
///
/// This rule checks whether the length of the input value is **greater than or equal to** a specified minimum.
/// If the input value is shorter, the specified error is thrown.
///
/// # Example
/// ```swift
/// let rule = MinLengthRule(in: 5, error: ValidationError.tooShort)
/// do {
///     try rule.validate(6)  // ✅ Valid (6 ≥ 5)
///     try rule.validate(4)  // ❌ Throws ValidationError.tooShort
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// # Notes
/// - If `value` is `nil`, validation passes automatically.
/// - This rule ensures **greater than or equal to** (`≥`), not strictly greater than (`>`).
/// - Can be used for strings, arrays, or any type conforming to `Mensurable`.
public struct MinLengthRule: FormFieldRule {
    
    public typealias Value = Mensurable
    
    // MARK: - Private Properties
    
    private let value: Value
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that validates whether a value meets the minimum required length.
    ///
    /// - Parameters:
    ///   - value: The minimum length required.
    ///   - error: The error to throw if validation fails.
    public init(in value: Value, error: Error) {
        self.value = value
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates that the given value meets the minimum length requirement.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value is shorter than the minimum required length.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        if self.value.length > value.length {
            throw error
        }
    }
    
}






