//
//  MinLengthKeyPathRule.swift
//  Formidable
//
//  Created by Adriano Costa on 04/02/25.
//

public struct MinLengthKeyPathRule<Root, Value: Mensurable>: FormFieldRule {
    
    public typealias Transform = (Value) -> Value
    
    // MARK: - Public Properties
    
    public var transform: Transform?
    
    // MARK: - Private Properties
    
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
        
        if transformedValue.length < value.length {
            throw error
        }
    }
    
}






