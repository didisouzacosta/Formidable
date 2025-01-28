//
//  UniqueRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

public struct UniqueRule<Root, Value: Equatable>: FormFieldRule {
    
    public typealias Items = [Value]
    
    // MARK: - Private Properties
    
    private let reference: ReferenceValue<Items, Root>
    private let referenceRoot: Root!
    private let transform: ((Items) -> Items)?
    private let error: Error
    
    // MARK: - Initializers
    
    public init(in items: Items, error: Error) {
        self.reference = .staticValue(items)
        self.referenceRoot = nil
        self.transform = nil
        self.error = error
    }
    
    public init(
        _ referenceRoot: Root,
        keyPath: KeyPath<Root, Items>,
        transform: ((Items) -> Items)? = nil,
        error: Error
    ) {
        self.reference = .keyPath(keyPath)
        self.referenceRoot = referenceRoot
        self.transform = transform
        self.error = error
    }
    
    // MARK: - Public Methods
    
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        let referenceValue: Items
        
        switch reference {
        case .staticValue(let staticValue):
            referenceValue = staticValue
        case .keyPath(let keyPath):
            referenceValue = referenceRoot[keyPath: keyPath]
        }
        
        let referenceValueTransformed = transform?(referenceValue) ?? referenceValue
        
        if referenceValueTransformed.contains(value) {
            throw error
        }
    }
    
}




