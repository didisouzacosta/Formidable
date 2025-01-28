//
//  UniqueRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A validation rule that ensures a given value does not exist in a reference collection.
///
/// The `UniqueRule` is used to validate that a value is unique within a static or dynamic collection.
/// This is particularly useful for enforcing uniqueness constraints in forms, such as ensuring that
/// usernames or email addresses are not duplicated.
///
/// - Generics:
///   - `Root`: The type of the object containing the reference collection when using a dynamic reference.
///   - `Value`: The type of the value to validate, which must conform to `Equatable`.
public struct UniqueRule<Root, Value: Equatable>: FormFieldRule {
    
    public typealias Items = [Value]
    
    // MARK: - Private Properties
    
    private let reference: ReferenceValue<Items, Root>
    private let referenceRoot: Root?
    private let transform: ((Items) -> Items)?
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that validates a value against a static reference collection.
    ///
    /// - Parameters:
    ///   - items: The static collection of values to compare against.
    ///   - error: The error to throw if validation fails.
    ///
    /// - Example:
    ///   ```swift
    ///   let existingEmails = ["test@example.com", "user@example.com"]
    ///   let rule = UniqueRule(in: existingEmails, error: ValidationError.duplicateEmail)
    ///
    ///   do {
    ///       try rule.validate("new@example.com") // Passes validation
    ///       try rule.validate("test@example.com") // Throws ValidationError.duplicateEmail
    ///   } catch {
    ///       print(error)
    ///   }
    ///   ```
    public init(in items: Items, error: Error) {
        self.reference = .staticValue(items)
        self.referenceRoot = nil
        self.transform = nil
        self.error = error
    }
    
    /// Creates a rule that validates a value against a dynamic reference collection.
    ///
    /// - Parameters:
    ///   - referenceRoot: The object containing the dynamic reference collection.
    ///   - keyPath: A `KeyPath` to the reference collection on the `referenceRoot`.
    ///   - transform: An optional closure to transform the reference collection before comparison.
    ///   - error: The error to throw if validation fails.
    ///
    /// - Example:
    ///   ```swift
    ///   struct UserDatabase {
    ///       var existingUsernames: [String] = ["user1", "user2"]
    ///   }
    ///
    ///   let database = UserDatabase()
    ///   let rule = UniqueRule(database, keyPath: \.existingUsernames, error: ValidationError.duplicateUsername)
    ///
    ///   do {
    ///       try rule.validate("newUser") // Passes validation
    ///       try rule.validate("user1")  // Throws ValidationError.duplicateUsername
    ///   } catch {
    ///       print(error)
    ///   }
    ///   ```
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
    
    /// Validates that the given value does not exist in the reference collection.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value exists in the reference collection.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        let referenceValue: Items
        
        switch reference {
        case .staticValue(let staticValue):
            referenceValue = staticValue
        case .keyPath(let keyPath):
            guard let referenceRoot else {
                fatalError("`referenceRoot` is nil. This should never happen when using a KeyPath.")
            }
            referenceValue = referenceRoot[keyPath: keyPath]
        }
        
        let referenceValueTransformed = transform?(referenceValue) ?? referenceValue
        
        if referenceValueTransformed.contains(value) {
            throw error
        }
    }
    
}




