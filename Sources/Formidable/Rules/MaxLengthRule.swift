//
//  MaxLengthRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

public struct MaxLengthRule: FormFieldRule {
    
    public typealias Value = Mensurable
    
    // MARK: - Private Properties
    
    private let value: Value
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that validates a value against a static reference value.
    ///
    /// - Parameters:
    ///   - value: The static maximum length allowed.
    ///   - error: The error to throw if validation fails.
    public init(in value: Value, error: Error) {
        self.value = value
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates that the given value does not exceed the maximum allowed length.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value length exceeds the reference value.
    public func validate(_ value: Value?) throws {
        if self.value.length < (value?.length ?? 0) {
            throw error
        }
    }
    
}





