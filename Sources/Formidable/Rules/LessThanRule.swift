//
//  LessThanRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

import Foundation

public struct LessThanRule<Value: Comparable>: FormFieldRule {
    
    // MARK: - Private Properties
    
    private let value: Value
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that validates a value against a static reference value.
    ///
    /// - Parameters:
    ///   - staticValue: The static reference value to compare against.
    ///   - error: The error to throw if validation fails.
    public init(
        _ value: Value,
        error: Error
    ) {
        self.value = value
        self.error = error
    }
    
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        if value >= self.value {
            throw error
        }
    }
    
}
