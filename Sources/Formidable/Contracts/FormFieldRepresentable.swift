//
//  FormFieldRepresentable.swift
//  Formidable
//
//  Created by Adriano Costa on 24/01/25.
//

import SwiftUI

/// The common contract for fields discovered and managed by a ``Formidable`` form.
///
/// Conforming types expose their current and original values, presentation state, transformation, and rules.
/// External conformers inherit default validation and reset behavior.
///
/// # Example
///
/// ```swift
/// final class CustomField: FormFieldRepresentable {
///     var value = ""
///     let originalValue = ""
///     var isHidden = false
///     var isDisabled = false
///     var showErrors = false
///     var rules: [any FormFieldRule] = []
///     var transform: ((String) -> String)?
/// }
/// ```
public protocol FormFieldRepresentable: ObservableObject {

    /// The concrete value managed by the field.
    associatedtype Value: Equatable

    /// The current value used by validation.
    var value: Value { get set }
    /// The value used to determine whether the field was modified.
    var originalValue: Value { get }
    /// Indicates whether the current value differs from ``originalValue``.
    var isModified: Bool { get }
    /// Indicates whether the field is hidden and excluded from validation.
    var isHidden: Bool { get set }
    /// Indicates whether the field is disabled and excluded from validation.
    var isDisabled: Bool { get set }
    /// Indicates whether validation errors should be presented.
    var showErrors: Bool { get set }
    /// The validation rules evaluated against ``value``.
    var rules: [any FormFieldRule] { get set }
    /// An optional transformation applied by the conforming field.
    var transform: ((Value) -> Value)? { get set }

    /// Restores the field to its initial value and clears error presentation.
    func reset()

}

extension FormFieldRepresentable {

    // MARK: - Public Properties

    /// Indicates whether the field currently satisfies every validation rule.
    public var isValid: Bool {
        errors.isEmpty
    }

    /// Indicates whether the current value differs from ``originalValue``.
    public var isModified: Bool {
        originalValue != value
    }

    /// The validation errors produced by the field's rules, or an empty array when hidden or disabled.
    public var errors: [any Error] {
        guard !isDisabled, !isHidden else { return [] }

        return rules.compactMap { rule in
            do {
                try AnyRule(rule).validate(value)
                return nil
            } catch {
                return error
            }
        }
    }

    // MARK: - Public Methods

    /// Restores ``originalValue`` and clears error presentation.
    ///
    /// Concrete conformers may override this default when they need to retain a separate raw initial value.
    public func reset() {
        value = originalValue
        showErrors = false
    }

}
