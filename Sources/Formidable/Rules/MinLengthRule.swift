//
//  MinLengthRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

public struct MinLengthRule: FormFieldRule {
    
    public typealias Value = Mensurable
    
    // MARK: - Private Properties
    
    private let value: Value
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that validates a value against a static reference value.
    ///
    /// - Parameters:
    ///   - value: The static minimum length allowed.
    ///   - error: The error to throw if validation fails.
    public init(in value: Value, error: Error) {
        self.value = value
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates that the given value meets the minimum required length.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value length is smaller than the reference value.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        if self.value.length > value.length {
            throw error
        }
    }
    
}





