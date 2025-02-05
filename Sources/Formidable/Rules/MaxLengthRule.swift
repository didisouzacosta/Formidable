//
//  MaxLengthRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A validation rule that ensures a value does not exceed a maximum allowed length.
///
/// ### Example Usage:
/// ```swift
/// struct FormData: Mensurable {
///     let length: Int
/// }
///
/// let maxLength = FormData(length: 10)
/// let rule = MaxLengthRule(maxLength, error: ValidationError.tooLong)
///
/// do {
///     try rule.validate(FormData(length: 10)) // ✅ Passes validation
///     try rule.validate(FormData(length: 12)) // ❌ Throws ValidationError.tooLong
/// } catch {
///     print(error)
/// }
/// ```
///
/// - Parameters:
///   - Value: A type conforming to `Mensurable`, which provides a `length` property for comparison.
public struct MaxLengthRule: FormFieldRule {
    
    public typealias Value = Mensurable
    
    // MARK: - Private Properties
    
    private let referenceValue: Value
    private let error: Error
    
    // MARK: - Initializers
    
    /// Initializes a new rule to validate that a value does not exceed a maximum length.
    ///
    /// - Parameters:
    ///   - referenceValue: The value defining the maximum length allowed.
    ///   - error: The error to throw if validation fails.
    public init(_ referenceValue: Value, error: Error) {
        self.referenceValue = referenceValue
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates that the given value does not exceed the maximum length.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if validation fails.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        if value.length > referenceValue.length {
            throw error
        }
    }
    
}






