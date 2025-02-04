//
//  MaxLengthRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

public struct MaxLengthRule: FormFieldRule {
    
    public typealias Reference = Mensurable
    public typealias Value = Int
    
    // MARK: - Private Properties
    
    private let referenceValue: Reference
    private let error: Error
    
    // MARK: - Initializers
    
    public init(_ referenceValue: Reference, error: Error) {
        self.referenceValue = referenceValue
        self.error = error
    }
    
    // MARK: - Public Methods
    
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        if value.length > referenceValue.length {
            throw error
        }
    }
    
}






