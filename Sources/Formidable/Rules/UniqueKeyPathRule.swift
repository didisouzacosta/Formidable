//
//  UniqueKeyPathRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

public struct UniqueKeyPathRule<Root, Value: Equatable>: FormFieldRule {
    
    public typealias Values = [Value]
    public typealias Transform = (Values) -> Values
    
    // MARK: - Public Properties
    
    public var transform: Transform?
    
    // MARK: - Private Properties
    
    private let root: Root
    private let keyPath: KeyPath<Root, Values>
    private let error: Error
    
    // MARK: - Initializers

    public init(
        _ root: Root,
        keyPath: KeyPath<Root, Values>,
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
        
        if transformedValue.contains(value) {
            throw error
        }
    }
    
}





