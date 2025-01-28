//
//  GreaterThanRule.swift
//  Formidable
//
//  Created by Adriano Costa on 14/01/25.
//

/// A generic validation rule that ensures a value is greater than a reference value.
///
/// The reference value can be either:
/// - A static value provided at initialization.
/// - A dynamic value derived from a `KeyPath` on a reference object.
///
/// Additionally, a transformation closure can be applied to the reference value
/// before comparison.
///
/// - Generic Parameters:
///   - `Root`: The type of the object that contains the dynamic reference value.
///   - `Value`: The type of the value being compared. Must conform to `Comparable`.
///
/// ## Example Usage
///
/// ### Static Value Comparison
/// ```swift
/// enum ValidationError: Error {
///     case tooSmall
/// }
///
/// let rule = GreaterThanRule(
///     staticValue: 10,
///     error: ValidationError.tooSmall
/// )
///
/// do {
///     try rule.validate(5)  // Throws ValidationError.tooSmall
///     try rule.validate(15) // Passes
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// ### Dynamic Value Comparison Using KeyPath
/// ```swift
/// struct Person {
///     let age: Int
/// }
///
/// enum ValidationError: Error {
///     case tooSmall
/// }
///
/// let person = Person(age: 18)
///
/// let rule = GreaterThanRule(
///     referenceRoot: person,
///     keyPath: \Person.age,
///     error: ValidationError.tooSmall
/// )
///
/// do {
///     try rule.validate(16)  // Throws ValidationError.tooSmall
///     try rule.validate(20)  // Passes
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// ### Using a Transformation Closure
/// ```swift
/// enum ValidationError: Error {
///     case tooSmall
/// }
///
/// let rule = GreaterThanRule(
///     staticValue: 10,
///     transform: { $0 + 5 }, // Adds 5 to the reference value
///     error: ValidationError.tooSmall
/// )
///
/// do {
///     try rule.validate(12) // Throws ValidationError.tooSmall (10 + 5 > 12)
///     try rule.validate(16) // Passes
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
public struct GreaterThanRule<Root, Value: Comparable>: FormFieldRule {
    
    // MARK: - Private Properties
    
    private let reference: ReferenceValue<Value, Root>
    private let referenceRoot: Root!
    private let transform: ((Value) -> Value)?
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that validates a value against a static reference value.
    ///
    /// - Parameters:
    ///   - staticValue: The static reference value to compare against.
    ///   - error: The error to throw if validation fails.
    public init(
        _ staticValue: Value,
        error: Error
    ) {
        self.reference = .staticValue(staticValue)
        self.referenceRoot = nil
        self.transform = nil
        self.error = error
    }
    
    /// Creates a rule that validates a value against a dynamic reference value.
    ///
    /// - Parameters:
    ///   - referenceRoot: The object containing the dynamic reference value.
    ///   - keyPath: A `KeyPath` to the reference value on the `referenceRoot`.
    ///   - transform: An optional closure to transform the reference value before comparison. Defaults to `nil`.
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
    
    /// Validates the given value to ensure it is greater than the reference value.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the validation fails.
    ///
    /// - Behavior:
    ///   1. If `value` is `nil`, the validation passes without throwing an error.
    ///   2. If the reference value is dynamic, it is retrieved using the provided `KeyPath` from `referenceRoot`.
    ///   3. If a `valueTransformer` is provided, it is applied to the reference value.
    ///   4. If `value` is less than the transformed reference value, the specified error is thrown.
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
        
        if value < referenceValueTransformed {
            throw error
        }
    }
    
}


