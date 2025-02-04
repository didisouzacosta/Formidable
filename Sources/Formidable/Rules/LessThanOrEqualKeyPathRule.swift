//
//  LessThanOrEqualKeyPathRule.swift
//  Formidable
//
//  Created by Adriano Costa on 04/02/25.
//

public struct LessThanOrEqualKeyPathRule<Root, Value: Comparable>: FormFieldRule {
    
    // MARK: - Private Variables
    
    private let root: Root
    private let keyPath: KeyPath<Root, Value>
    private let error: Error
    
    // MARK: - Initializers
    
    public init(
        _ root: Root,
        keyPath: KeyPath<Root, Value>,
        error: Error
    ) {
        self.root = root
        self.keyPath = keyPath
        self.error = error
    }
    
    // MARK: - Public Methods
    
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        let referenceValue = root[keyPath: keyPath]
        
        if value > referenceValue  {
            throw error
        }
    }
    
}
