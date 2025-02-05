//
//  UniqueRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A validation rule that ensures a value is unique within a collection.
///
/// This rule checks whether the input value exists in a predefined collection of values.
/// If the value already exists in the collection, the specified error is thrown.
///
/// # Example
/// ```swift
/// let existingItems = ["apple", "banana", "cherry"]
/// let rule = UniqueRule(in: existingItems, error: ValidationError.notUnique)
/// do {
///     try rule.validate("orange") // ✅ Valid (not in the collection)
///     try rule.validate("apple") // ❌ Throws ValidationError.notUnique
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// # Notes
/// - If the value is `nil`, validation passes automatically (no need to check uniqueness).
/// - This rule ensures that the value does not already exist in the collection.
/// - Can be used for strings, numbers, or any type conforming to `Equatable`.
public struct UniqueRule<Value: Equatable>: FormFieldRule {
    
    public typealias Items = [Value]
    
    // MARK: - Private Properties
    
    private let items: Items
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that ensures a value is unique within a specified collection.
    ///
    /// - Parameters:
    ///   - items: The collection of values to check uniqueness against.
    ///   - error: The error to throw if validation fails.
    public init(in items: Items, error: Error) {
        self.items = items
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates that the given value is unique within the collection.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value already exists in the collection.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        if items.contains(value) {
            throw error
        }
    }
    
}





