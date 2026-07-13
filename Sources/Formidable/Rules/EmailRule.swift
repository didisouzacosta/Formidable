//
//  EmailRule.swift
//  Formidable
//
//  Created by Adriano Costa on 31/01/25.
//

import Foundation

/// A rule that validates a non-`nil` string against the SDK's email-address pattern.
///
/// A `nil` value passes so optionality can be handled independently by ``RequiredRule``.
///
/// # Example
///
/// ```swift
/// enum ValidationError: Error {
///     case invalidEmail
/// }
///
/// let rule = EmailRule(ValidationError.invalidEmail)
/// try rule.validate("user@example.com")
/// ```
public struct EmailRule: FormFieldRule {

    // MARK: - Private Properties

    private let error: any Error

    // MARK: - Initializer

    /// Creates an email validation rule.
    ///
    /// - Parameter error: The error thrown when a non-`nil` value does not match the email pattern.
    public init(_ error: any Error) {
        self.error = error
    }

    // MARK: - Public Methods

    /// Validates the supplied email address.
    public func validate(_ value: String?) throws {
        guard let value else { return }

        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let isValid = NSPredicate(format: "SELF MATCHES %@", emailPattern).evaluate(with: value)

        if !isValid {
            throw error
        }
    }

}
