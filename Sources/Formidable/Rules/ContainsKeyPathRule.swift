//
//  ContainsKeyPathRule.swift
//  Formidable
//
//  Created by Adriano Costa on 04/02/25.
//

/// A rule that validates whether a given value exists in a collection referenced by a key path.
///
/// ## Example
/// ```swift
/// struct User {
///     let allowedEmails: [String]
/// }
///
/// let user = User(allowedEmails: ["test@example.com", "admin@example.com"])
/// let rule = ContainsKeyPathRule(user, keyPath: \.allowedEmails, error: ValidationError.invalidEmail)
///
/// do {
///     try rule.validate("test@example.com") // ✅ Passes validation
///     try rule.validate("user@example.com") // ❌ Throws ValidationError.invalidEmail
/// } catch {
///     print(error)
/// }
/// ```
///
/// This rule checks if the provided value is contained within a dynamically accessed collection
/// using a `KeyPath` from a root object. An optional transformation can be applied to modify
/// the reference collection before validation.
public struct ContainsKeyPathRule<Root, Value: Equatable>: FormFieldRule {
    
    public typealias Values = [Value]
    public typealias Transform = (Values) -> Values
    
    // MARK: - Public Properties
    
    /// An optional transformation applied to the reference collection before validation.
    public var transform: Transform?
    
    // MARK: - Private Properties
    
    private let root: Root
    private let keyPath: KeyPath<Root, Values>
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that validates whether a given value exists in a dynamically referenced collection.
    ///
    /// - Parameters:
    ///   - root: The object containing the reference collection.
    ///   - keyPath: A `KeyPath` to the collection within the root object.
    ///   - error: The error to throw if validation fails.
    ///   - transform: An optional closure to modify the reference collection before validation.
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
    
    /// Validates that the given value exists in the reference collection.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value is not found in the reference collection.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        let referenceValue = root[keyPath: keyPath]
        let transformedValue = transform?(referenceValue) ?? referenceValue
        
        if !transformedValue.contains(value) {
            throw error
        }
    }
    
}






