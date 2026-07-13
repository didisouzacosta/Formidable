//
//  UniqueKeyPathRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A rule that requires a value not to exist in a collection read from a root object's key path.
///
/// The reference collection is read on every validation, so changes made through a reference-type root are
/// reflected dynamically. A `nil` value passes validation.
///
/// # Example
///
/// ```swift
/// enum ValidationError: Error {
///     case duplicateEmail
/// }
///
/// final class Directory {
///     var emails = ["registered@example.com"]
/// }
///
/// let directory = Directory()
/// let rule = UniqueKeyPathRule(
///     directory,
///     keyPath: \.emails,
///     error: ValidationError.duplicateEmail
/// )
/// try rule.validate("new@example.com")
/// ```
public struct UniqueKeyPathRule<Root, Value: Equatable>: FormFieldRule {

    // MARK: - Public Properties

    /// The collection read from the root object.
    public typealias Values = [Value]
    /// A transformation applied to the reference collection before validation.
    public typealias Transform = (Values) -> Values
    /// An optional transformation applied to the current reference collection.
    public var transform: Transform?

    // MARK: - Private Properties

    private let root: Root
    private let keyPath: KeyPath<Root, Values>
    private let error: any Error

    // MARK: - Initializer

    /// Creates a rule backed by a collection key path.
    ///
    /// - Parameters:
    ///   - root: The object containing the reference collection.
    ///   - keyPath: The key path to the collection.
    ///   - error: The error thrown when the collection already contains the value.
    ///   - transform: An optional transformation of the reference collection.
    public init(
        _ root: Root,
        keyPath: KeyPath<Root, Values>,
        error: any Error,
        transform: Transform? = nil
    ) {
        self.root = root
        self.keyPath = keyPath
        self.error = error
        self.transform = transform
    }

    // MARK: - Public Methods

    /// Validates that the current reference collection does not contain the supplied value.
    public func validate(_ value: Value?) throws {
        guard let value else { return }

        let referenceValue = root[keyPath: keyPath]
        let transformedValue = transform?(referenceValue) ?? referenceValue

        if transformedValue.contains(value) {
            throw error
        }
    }

}
