import SwiftUI

/// A form-management contract that discovers fields with reflection and provides validation and reset behavior.
///
/// `Formidable` has no actor isolation requirement. Its default implementation reflects the conforming value's
/// stored properties in declaration order and manages those conforming to ``FormFieldRepresentable``.
///
/// # Example
///
/// ```swift
/// enum ValidationError: Error {
///     case required
/// }
///
/// @Observable
/// final class UserForm: Formidable {
///     var name = FormField(
///         "",
///         rules: [RequiredRule(ValidationError.required)]
///     )
/// }
///
/// let form = UserForm()
/// try form.validate()
/// form.reset()
/// ```
public protocol Formidable {}

extension Formidable {

    // MARK: - Public Properties

    /// Indicates whether every discovered field is disabled, and updates all fields when assigned.
    public var isDisabled: Bool {
        get { fields.allSatisfy { $0.isDisabled } }
        set {
            for field in fields {
                field.isDisabled = newValue
            }
        }
    }

    /// Indicates whether every discovered field currently passes validation.
    public var isValid: Bool {
        errors.isEmpty
    }

    /// Indicates whether at least one discovered field differs from its original value.
    public var isModified: Bool {
        fields.contains { $0.isModified }
    }

    /// The validation errors from all discovered fields, preserving field and rule order.
    public var errors: [any Error] {
        fields.flatMap { $0.errors }
    }

    /// The fields discovered among the conforming value's stored properties.
    public var fields: [any FormFieldRepresentable] {
        Mirror(reflecting: self).children.compactMap { child in
            child.value as? any FormFieldRepresentable
        }
    }

    // MARK: - Public Methods

    /// Enables error presentation and throws the first validation error unless every field is disabled.
    ///
    /// - Throws: The first error in reflected field and rule order.
    public func validate() throws {
        guard !isDisabled else { return }

        for field in fields {
            field.showErrors = true
        }

        if let error = errors.first {
            throw error
        }
    }

    /// Resets every discovered field through its concrete protocol witness.
    public func reset() {
        for field in fields {
            field.reset()
        }
    }

}
