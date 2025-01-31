//
//  RequiredRule.swift
//  Formidable
//
//  Created by Adriano Costa on 14/01/25.
//

import SwiftUI

/// A validation rule that ensures a value is not empty or `nil`.
///
/// This rule checks whether the input value exists and is not empty.
/// If the value is `nil` or empty, the specified error is thrown.
///
/// # Example
/// ```swift
/// let rule = RequiredRule(ValidationError.required)
/// do {
///     try rule.validate("Hello")  // ✅ Valid (not empty)
///     try rule.validate("")       // ❌ Throws ValidationError.required
///     try rule.validate(nil)      // ❌ Throws ValidationError.required
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// # Notes
/// - If the value is `nil`, validation fails.
/// - If the value is empty, validation fails.
/// - Can be used for strings, collections, or any type conforming to `Emptable`.
public struct RequiredRule: FormFieldRule {
    
    public typealias T = Emptable
    
    // MARK: - Private Variables
    
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that ensures a value is not empty or `nil`.
    ///
    /// - Parameter error: The error to throw if validation fails.
    public init(_ error: Error) {
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates that the given value is not empty or `nil`.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value is `nil` or empty.
    public func validate(_ value: T?) throws {
        guard let value, !value.isEmpty else {
            throw error
        }
    }
    
}



