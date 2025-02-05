//
//  GreaterThanKeyPathRule.swift
//  Formidable
//
//  Created by Adriano Costa on 04/02/25.
//

/// A validation rule that ensures a value is greater than a reference value obtained via a `KeyPath` from a root object.
///
/// ### Example Usage:
/// ```swift
/// struct FormData {
///     let minAge: Int
/// }
///
/// let formData = FormData(minAge: 18)
/// let rule = GreaterThanKeyPathRule(formData, keyPath: \ .minAge, error: ValidationError.tooYoung)
///
/// do {
///     try rule.validate(19) // ✅ Passes validation
///     try rule.validate(16) // ❌ Throws ValidationError.tooYoung    
/// } catch {
///     print(error)
/// }
/// ```
///
/// - Parameters:
///   - Root: The type of the root object containing the reference value.
///   - Value: The type of value being validated, which must conform to `Comparable`.
public struct GreaterThanKeyPathRule<Root, Value: Comparable>: FormFieldRule {
    
    public typealias Transform = (Value) -> Value
    
    // MARK: - Public Variables
    
    /// A closure to transform the reference value before comparison, if needed.
    public var transform: Transform?
    
    // MARK: - Private Variables
    
    private let root: Root
    private let keyPath: KeyPath<Root, Value>
    private let error: Error
    
    // MARK: - Initializers
    
    /// Initializes the rule with a root object, key path, validation error, and an optional transformation.
    ///
    /// - Parameters:
    ///   - root: The root object containing the reference value.
    ///   - keyPath: The `KeyPath` to access the reference value.
    ///   - error: The error to throw if validation fails.
    ///   - transform: An optional closure to transform the reference value before comparison.
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
    
    /// Validates that the given value is strictly greater than the reference value obtained via the key path.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the validation fails.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        let referenceValue = root[keyPath: keyPath]
        let transformedValue = transform?(referenceValue) ?? referenceValue
        
        if value <= transformedValue  {
            throw error
        }
    }
    
}
