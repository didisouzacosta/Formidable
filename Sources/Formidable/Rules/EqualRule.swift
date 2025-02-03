//
//  EqualRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A validation rule that ensures a given value is equal to a reference value.
///
/// This rule checks whether the input value is **equal to** a specified reference value.
/// If the input value is not equal to the reference value, the specified error is thrown.
///
/// # Example
/// ```swift
/// let rule = EqualRule(10, error: ValidationError.notEqual)
/// do {
///     try rule.validate(10)  // ✅ Valid (10 == 10)
///     try rule.validate(5)   // ❌ Throws ValidationError.notEqual
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// # Notes
/// - If the value is `nil`, validation passes automatically.
/// - This rule ensures equality (`==`), comparing the values for strict equivalence.
/// - Can be used for types conforming to `Equatable`.
public struct EqualRule<Value: Equatable>: FormFieldRule {
    
    // MARK: - Private Properties
    
    private let value: Value
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that ensures a value is equal to a reference value.
    ///
    /// - Parameters:
    ///   - value: The reference value to compare against.
    ///   - error: The error to throw if validation fails.
    public init(_ value: Value, error: Error) {
        self.value = value
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates that the given value is equal to the reference value.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value is not equal to the reference value.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        if self.value != value {
            throw error
        }
    }
    
}

public struct EqualKeyPathRule<Root, Value: Equatable>: FormFieldRule {
    
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
        
        if referenceValue != value {
            throw error
        }
    }
    
}
