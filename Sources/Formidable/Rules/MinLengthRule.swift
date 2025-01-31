//
//  MinLengthRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

public struct MinLengthRule<Root, Value: Mensurable>: FormFieldRule {
    
    // MARK: - Private Properties
    
    private let reference: ReferenceValue<Value, Root>
    private let referenceRoot: Root!
    private let transform: ((Value) -> Value)?
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that validates a value against a static reference value.
    ///
    /// - Parameters:
    ///   - items: The static collection of values to compare against.
    ///   - error: The error to throw if validation fails.
    public init(in value: Value, error: Error) {
        self.reference = .staticValue(value)
        self.referenceRoot = nil
        self.transform = nil
        self.error = error
    }
    
    /// Creates a rule that validates a value against a dynamic reference value.
    ///
    /// - Parameters:
    ///   - referenceRoot: The object containing the dynamic reference value.
    ///   - keyPath: A `KeyPath` to the reference collection on the `referenceRoot`.
    ///   - transform: An optional closure to transform the reference value before comparison.
    ///   - error: The error to throw if validation fails.
    public init(
        _ referenceRoot: Root,
        keyPath: KeyPath<Root, Value>,
        transform: ((Value) -> Value)? = nil,
        error: Error
    ) {
        self.reference = .keyPath(keyPath)
        self.referenceRoot = referenceRoot
        self.transform = transform
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates that the given value does not exist in the reference value.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value exists in the reference value.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        let referenceValue: Value
        
        switch reference {
        case .staticValue(let staticValue):
            referenceValue = staticValue
        case .keyPath(let keyPath):
            referenceValue = referenceRoot[keyPath: keyPath]
        }
        
        let referenceValueTransformed = transform?(referenceValue) ?? referenceValue
        
        if value.length < referenceValueTransformed.length {
            throw error
        }
    }
    
}




