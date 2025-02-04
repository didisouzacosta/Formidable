//
//  LessThanOrEqualKeyPathRule.swift
//  Formidable
//
//  Created by Adriano Costa on 04/02/25.
//

public struct LessThanOrEqualKeyPathRule<Root, Value: Comparable>: FormFieldRule {
    
    public typealias Transform = (Value) -> Value
    
    // MARK: - Public Variables
    
    var transform: Transform?
    
    // MARK: - Private Variables
    
    private let root: Root
    private let keyPath: KeyPath<Root, Value>
    private let error: Error
    
    // MARK: - Initializers
    
    public init(
        _ root: Root,
        keyPath: KeyPath<Root, Value>,
        error: Error,
        transform: Transform? = nil
    ) {
        self.root = root
        self.keyPath = keyPath
        self.error = error
        self.transform = transform
    }
    
    // MARK: - Public Methods
    
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        let referenceValue = root[keyPath: keyPath]
        let transformedValue = transform?(referenceValue) ?? referenceValue
        
        if value > transformedValue  {
            throw error
        }
    }
    
}
