//
//  EmailRule.swift
//  Formidable
//
//  Created by Adriano Costa on 31/01/25.
//

import Foundation

public struct EmailRule: FormFieldRule {
    
    // MARK: - Private Properties
    
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that validates a value against a static reference value.
    ///
    /// - Parameters:
    ///   - items: The static collection of values to compare against.
    ///   - error: The error to throw if validation fails.
    public init(_ error: Error) {
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates that the given value does not exist in the reference value.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value exists in the reference value.
    public func validate(_ value: String?) throws {
        guard let value else { return }
        
        let isValid = NSPredicate(
            format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        ).evaluate(with: value)
        
        if !isValid {
            throw error
        }
    }
    
}




