//
//  GreaterThanOrEqualKeyPathRule.swift
//  Formidable
//
//  Created by Adriano Costa on 04/02/25.
//

/// A validation rule that ensures a given value is greater than or equal to a reference value
/// obtained dynamically via a `KeyPath` on a root object.
///
/// ### Example Usage:
/// ```swift
/// struct User {
///     let minimumAge: Int
/// }
///
/// let user = User(minimumAge: 18)
/// let rule = GreaterThanOrEqualKeyPathRule(user, keyPath: \User.minimumAge, error: ValidationError.tooYoung)
///
/// do {
///     try rule.validate(20) // ✅ Passes validation
///     try rule.validate(16) // ❌ Throws ValidationError.tooYoung
/// } catch {
///     print(error)
/// }
/// ```
///
/// - Parameters:
///   - Root: The type of the root object containing the reference value.
///   - Value: A `Comparable` type representing the value being validated.
public struct GreaterThanOrEqualKeyPathRule<Root, Value: Comparable>: FormFieldRule {
    
    public typealias Transform = (Value) -> Value
    
    // MARK: - Public Properties
    
    /// An optional transformation function to modify the reference value before validation.
    public var transform: Transform?
    
    // MARK: - Private Properties
    
    private let root: Root
    private let keyPath: KeyPath<Root, Value>
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that validates whether a given value is greater than or equal to a
    /// dynamically obtained reference value from a root object using a `KeyPath`.
    ///
    /// - Parameters:
    ///   - root: The root object containing the reference value.
    ///   - keyPath: The `KeyPath` to the reference value on the root object.
    ///   - error: The error thrown if validation fails.
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
    
    /// Validates whether the given value is greater than or equal to the reference value
    /// obtained from the `KeyPath` of the root object.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the validation fails.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        let referenceValue = root[keyPath: keyPath]
        let transformedValue = transform?(referenceValue) ?? referenceValue
        
        if value < transformedValue {
            throw error
        }
    }
    
}
