//
//  ContainsRule.swift
//  Formidable
//
//  Created by Adriano Costa on 04/02/25.
//

/// A validation rule that ensures that value contains in collection.
///
/// This rule checks whether the input value contains in a predefined collection of values.
/// If the value not exists in the collection, the specified error is thrown.
///
/// # Example
/// ```swift
/// let items = ["apple", "banana", "cherry"]
/// let rule = ContainsRule(in: items, error: ValidationError.notUnique)
/// do {
///     try rule.validate("banana")  // ✅ Valid (not contains in the collection)
///     try rule.validate("orange")   // ❌ Throws ValidationError.notContains
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// # Notes
/// - If the value is `nil`, validation passes automatically (no need to check uniqueness).
/// - This rule ensures that the value contains in the collection.
/// - Can be used for strings, numbers, or any type conforming to `Equatable`.
public struct ContainsRule<Value: Equatable>: FormFieldRule {
    
    public typealias Items = [Value]
    
    // MARK: - Private Properties
    
    private let items: Items
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that ensures a value is unique within a specified collection.
    ///
    /// - Parameters:
    ///   - items: The collection of values to check contains against.
    ///   - error: The error to throw if validation fails.
    public init(in items: Items, error: Error) {
        self.items = items
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates that the given value is unique within the collection.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value not contains in the collection.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        if !items.contains(value) {
            throw error
        }
    }
    
}





