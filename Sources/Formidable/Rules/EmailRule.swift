//
//  EmailRule.swift
//  Formidable
//
//  Created by Adriano Costa on 31/01/25.
//

import Foundation

/// A validation rule that ensures a given string is a valid email address.
///
/// The rule checks whether the provided value matches a standard email format using a regular expression.
/// If the validation fails, the specified error is thrown.
///
/// # Example
/// ```swift
/// let rule = EmailRule(ValidationError.invalidEmail)
/// do {
///     try rule.validate("user@example.com") // ✅ Valid email
///     try rule.validate("invalid-email")    // ❌ Throws ValidationError.invalidEmail
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// # Notes
/// - The validation uses a regular expression to check the email format, ensuring it follows
///   the common structure of `local-part@domain.tld`.
/// - If the value is `nil`, the validation passes automatically.
public struct EmailRule: FormFieldRule {
    
    // MARK: - Private Properties
    
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a new email validation rule.
    ///
    /// - Parameter error: The error to throw if the provided value is not a valid email.
    public init(_ error: Error) {
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates whether the given value is a correctly formatted email address.
    ///
    /// - Parameter value: The value to validate. If `nil`, the validation passes automatically.
    /// - Throws: The specified error if the value is not a valid email address.
    public func validate(_ value: String?) throws {
        guard let value else { return }
        
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let isValid = NSPredicate(format: "SELF MATCHES %@", emailPattern).evaluate(with: value)
        
        if !isValid {
            throw error
        }
    }
    
}





