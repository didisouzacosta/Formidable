//
//  LessThanOrEqualKeyPathRule.swift
//  Formidable
//
//  Created by Adriano Costa on 04/02/25.
//

/// A validation rule that ensures a value is less than or equal to a reference value obtained via a `KeyPath`.
///
/// ### Example Usage:
/// ```swift
/// struct FormData {
///     let maxValue: Int
/// }
///
/// let data = FormData(maxValue: 10)
/// let rule = LessThanOrEqualKeyPathRule(data, keyPath: \FormData.maxValue, error: ValidationError.outOfBounds)
///
/// do {
///     try rule.validate(10) // ✅ Passes validation
///     try rule.validate(12) // ❌ Throws ValidationError.outOfBounds
/// } catch {
///     print(error)
/// }
/// ```
///
/// - Parameters:
///   - Root: The root object containing the reference value.
///   - Value: A `Comparable` type for validation.
public struct LessThanOrEqualKeyPathRule<Root, Value: Comparable>: FormFieldRule {
    
    public typealias Transform = (Value) -> Value
    
    // MARK: - Public Variables
    
    /// Optional transformation closure applied to the reference value before comparison.
    public var transform: Transform?
    
    // MARK: - Private Variables
    
    private let root: Root
    private let keyPath: KeyPath<Root, Value>
    private let error: Error
    
    // MARK: - Initializers
    
    /// Initializes a new rule to validate that a value is less than or equal to a reference value.
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
    
    /// Validates that the given value is less than or equal to the reference value.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if validation fails.
    public func validate(_ value: Value?) throws {
        guard let value else { return }
        
        let referenceValue = root[keyPath: keyPath]
        let transformedValue = transform?(referenceValue) ?? referenceValue
        
        if value > transformedValue  {
            throw error
        }
    }
    
}
