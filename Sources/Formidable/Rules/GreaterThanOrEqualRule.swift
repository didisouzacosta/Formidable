//
//  GreaterThanOrEqualRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

public struct GreaterThanOrEqualRule<Value: Comparable>: FormFieldRule {
    
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
    
    // MARK: - Public Methods
    
    /// Validates the given value to ensure it is greater than or equal to the reference value.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the validation fails.
    ///
    /// - Behavior:
    ///   1. If `value` is `nil`, the validation passes without throwing an error.
    ///   2. If the reference value is dynamic, it is retrieved using the provided `KeyPath` from `referenceRoot`.
    ///   3. If a `transform` closure is provided, it is applied to the reference value.
    ///   4. If `value` is less than the transformed reference value, the specified error is thrown.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        if value < self.value {
            throw error
        }
    }
    
}

