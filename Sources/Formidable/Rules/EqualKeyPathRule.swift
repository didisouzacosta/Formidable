//
//  EqualKeyPathRule.swift
//  Formidable
//
//  Created by Adriano Costa on 04/02/25.
//

/// A validation rule that ensures a value is equal to a reference value obtained via a `KeyPath`.
///
/// ### Example Usage:
/// ```swift
/// struct FormData {
///     let requiredCode: String
/// }
///
/// let formData = FormData(requiredCode: "ABC123")
/// let rule = EqualKeyPathRule(formData, keyPath: \FormData.requiredCode, error: ValidationError.mismatch)
///
/// do {
///     try rule.validate("ABC123") // ✅ Passes validation
///     try rule.validate("XYZ789") // ❌ Throws ValidationError.mismatch
/// } catch {
///     print(error)
/// }
/// ```
///
/// - Parameters:
///   - Root: The root object containing the reference value.
///   - Value: A type conforming to `Equatable` used for comparison.
public struct EqualKeyPathRule<Root, Value: Equatable>: FormFieldRule {
    
    public typealias Transform = (Value) -> Value
    
    // MARK: - Public Variables
    
    /// An optional transformation function to modify the reference value before validation.
    public var transform: Transform?
    
    // MARK: - Private Variables
    
    private let root: Root
    private let keyPath: KeyPath<Root, Value>
    private let error: Error
    
    // MARK: - Initializers
    
    /// Initializes a new rule to validate that a value is equal to a dynamically obtained reference value.
    ///
    /// - Parameters:
    ///   - root: The object containing the reference value.
    ///   - keyPath: The `KeyPath` pointing to the reference value within `root`.
    ///   - error: The error to throw if validation fails.
    ///   - transform: An optional closure to modify the reference value before comparison.
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
    
    /// Validates that the given value is equal to the reference value obtained from the `KeyPath` of the root object.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the validation fails.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        let referenceValue = root[keyPath: keyPath]
        let transformedValue = transform?(referenceValue) ?? referenceValue
        
        if transformedValue != value {
            throw error
        }
    }
    
}

