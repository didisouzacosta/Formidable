//
//  MinLengthRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A validation rule that ensures a given value meets a minimum length requirement.
///
/// This rule compares the length of the input value against a static or dynamic reference value.
/// If the input value's length is smaller than the reference value, the specified error is thrown.
///
/// # Example
/// ```swift
/// let rule = MinLengthRule(in: 5, error: ValidationError.tooShort)
/// do {
///     try rule.validate(8)  // ✅ Valid (8 ≥ 5)
///     try rule.validate(3)  // ❌ Throws ValidationError.tooShort
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// # Notes
/// - The reference value can be **static** (a fixed number) or **dynamic** (retrieved using `KeyPath`).
/// - If a transformation closure is provided, it will be applied to the reference value before comparison.
/// - If `value` is `nil`, the validation passes automatically.
public struct MinLengthRule<Root, Value: Mensurable>: FormFieldRule {
    
    // MARK: - Private Properties
    
    private let reference: ReferenceValue<Value, Root>
    private let referenceRoot: Root!
    private let transform: ((Value) -> Value)?
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that validates a value against a static reference value.
    ///
    /// - Parameters:
    ///   - value: The static minimum length allowed.
    ///   - error: The error to throw if validation fails.
    public init(in value: Value, error: Error) {
        self.reference = .staticValue(value)
        self.referenceRoot = nil
        self.transform = nil
        self.error = error
    }
    
    /// Creates a rule that validates a value against a dynamic reference value.
    ///
    /// - Parameters:
    ///   - referenceRoot: The object containing the dynamic reference value.
    ///   - keyPath: A `KeyPath` to the reference value on the `referenceRoot`.
    ///   - transform: An optional closure to transform the reference value before comparison.
    ///   - error: The error to throw if validation fails.
    public init(
        _ referenceRoot: Root,
        keyPath: KeyPath<Root, Value>,
        transform: ((Value) -> Value)? = nil,
        error: Error
    ) {
        self.reference = .keyPath(keyPath)
        self.referenceRoot = referenceRoot
        self.transform = transform
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates that the given value meets the minimum required length.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value length is smaller than the reference value.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        let referenceValue: Value
        
        switch reference {
        case .staticValue(let staticValue):
            referenceValue = staticValue
        case .keyPath(let keyPath):
            referenceValue = referenceRoot[keyPath: keyPath]
        }
        
        let referenceValueTransformed = transform?(referenceValue) ?? referenceValue
        
        if value.length < referenceValueTransformed.length {
            throw error
        }
    }
    
}





