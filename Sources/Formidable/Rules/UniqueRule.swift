//
//  UniqueRule.swift
//  Formidable
//
//  Created by Adriano Costa on 26/01/25.
//

/// A rule that requires a non-`nil` value not to exist in a fixed collection.
///
/// A `nil` value passes so optionality can be handled independently by ``RequiredRule``.
///
/// # Example
///
/// ```swift
/// enum ValidationError: Error {
///     case duplicate
/// }
///
/// let rule = UniqueRule(in: ["taken"], error: ValidationError.duplicate)
/// try rule.validate("available")
/// ```
public struct UniqueRule<Value: Equatable>: FormFieldRule {

    // MARK: - Public Properties

    /// The collection type searched by the rule.
    public typealias Items = [Value]

    // MARK: - Private Properties

    private let items: Items
    private let error: any Error

    // MARK: - Initializer

    /// Creates a rule that searches a fixed collection.
    ///
    /// The labeled first parameter is retained for source compatibility.
    ///
    /// - Parameters:
    ///   - items: The collection in which the value must not exist.
    ///   - error: The error thrown when the collection contains the value.
    public init(in items: Items, error: any Error) {
        self.items = items
        self.error = error
    }

    // MARK: - Public Methods

    /// Validates that the collection does not contain the supplied value.
    public func validate(_ value: Value?) throws {
        guard let value else { return }

        if items.contains(value) {
            throw error
        }
    }

}
