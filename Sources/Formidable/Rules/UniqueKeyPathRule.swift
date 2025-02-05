//
//  UniqueKeyPathRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A validation rule that ensures a value is unique within a collection obtained via a `KeyPath`.
///
/// ### Example Usage:
/// ```swift
/// struct UserForm {
///     let registeredEmails: [String]
/// }
///
/// let form = UserForm(registeredEmails: ["test@example.com", "user@example.com"])
/// let rule = UniqueKeyPathRule(form, keyPath: \UserForm.registeredEmails, error: ValidationError.duplicateEntry)
///
/// do {
///     try rule.validate("new@example.com") // ✅ Passes validation
///     try rule.validate("test@example.com") // ❌ Throws ValidationError.duplicateEntry
/// } catch {
///     print(error)
/// }
/// ```
///
/// - Parameters:
///   - Root: The root object containing the collection of reference values.
///   - Value: An `Equatable` type for validation.
public struct UniqueKeyPathRule<Root, Value: Equatable>: FormFieldRule {
    
    public typealias Values = [Value]
    public typealias Transform = (Values) -> Values
    
    // MARK: - Public Properties
    
    /// Optional transformation closure applied to the reference values before validation.
    public var transform: Transform?
    
    // MARK: - Private Properties
    
    private let root: Root
    private let keyPath: KeyPath<Root, Values>
    private let error: Error
    
    // MARK: - Initializers
    
    /// Initializes a new rule to validate that a value is unique within a collection.
    ///
    /// - Parameters:
    ///   - root: The object containing the reference collection.
    ///   - keyPath: The `KeyPath` pointing to the collection within `root`.
    ///   - error: The error to throw if validation fails.
    ///   - transform: An optional closure to modify the collection before validation.
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
    
    /// Validates that the given value is unique within the reference collection.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if validation fails.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        let referenceValue = root[keyPath: keyPath]
        let transformedValue = transform?(referenceValue) ?? referenceValue
        
        if transformedValue.contains(value) {
            throw error
        }
    }
    
}





