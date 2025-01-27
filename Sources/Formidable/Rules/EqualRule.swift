//
//  EqualRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A validation rule that ensures a value is equal to a specified reference value.
///
/// The `EqualRule` compares a given value against either a static reference value or a value retrieved
/// dynamically using a `KeyPath` from a reference object. The rule throws the provided error if the values
/// do not match.
///
/// - Generic Parameters:
///   - `Root`: The type of the root object for the `KeyPath` when using a dynamic reference value.
///   - `Value`: The type of the values being compared, which must conform to `Equatable`.
///
/// ## Example Usage
///
/// ### Comparing to a Static Value
/// ```swift
/// enum ValidationError: Error {
///     case notEqual
/// }
///
/// let rule = EqualRule(staticValue: 10, error: ValidationError.notEqual)
///
/// do {
///     try rule.validate(10) // Passes
///     try rule.validate(5) // Throws ValidationError.notEqual
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// ### Comparing to a Dynamic Value via KeyPath
/// ```swift
/// struct Settings {
///     let maxValue: Int
/// }
///
/// let settings = Settings(maxValue: 100)
/// let rule = EqualRule(referenceRoot: settings, keyPath: \.maxValue, error: ValidationError.notEqual)
///
/// do {
///     try rule.validate(100) // Passes
///     try rule.validate(50) // Throws ValidationError.notEqual
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
public struct EqualRule<Root, Value: Equatable>: FormFieldRule {
    
    // MARK: - Private Properties
    
    /// The source of the reference value.
    private let reference: ReferenceValue<Value, Root>
    
    /// The object that contains the reference value when using a `KeyPath`.
    private let referenceRoot: Root?
    
    /// An optional closure to transform the reference value before comparison.
    private let transform: ((Value) -> Value)?
    
    /// The error to throw when validation fails.
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a rule that validates a value against a static reference value.
    ///
    /// - Parameters:
    ///   - staticValue: The static reference value to compare against.
    ///   - error: The error to throw if validation fails.
    public init(_ staticValue: Value, error: Error) {
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
    
    /// Validates that the given value is equal to the reference value.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value does not match the reference value.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        // Retrieve the reference value
        let referenceValue: Value
        
        switch reference {
        case .staticValue(let staticValue):
            referenceValue = staticValue
        case .keyPath(let keyPath):
            guard let referenceRoot else {
                fatalError("`referenceRoot` is nil. This should never happen when using a KeyPath.")
            }
            referenceValue = referenceRoot[keyPath: keyPath]
        }
        
        // Apply the transformer if available
        let anotherValueTransformed = transform?(referenceValue) ?? referenceValue
        
        // Perform the comparison
        if value != referenceValue {
            throw error
        }
    }
    
}

