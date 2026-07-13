//
//  FormField.swift
//  Formidable
//
//  Created by Adriano Costa on 23/01/25.
//

import SwiftUI

/// An observable form field that stores a value, applies transformations, and evaluates validation rules.
///
/// Assigning to ``value`` enables error presentation. When initialized with a `Binding`, reads and writes
/// stay synchronized with the external source. The optional ``transform`` closure is applied when the value
/// is read, including during validation.
///
/// # Example
///
/// ```swift
/// enum ValidationError: Error {
///     case required
/// }
///
/// let name = FormField(
///     "  Taylor  ",
///     rules: [RequiredRule(ValidationError.required)],
///     transform: { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
/// )
///
/// name.value = "  Swift  "
/// print(name.value) // "Swift"
/// name.reset()
/// ```
@Observable
public final class FormField<Value: Equatable>: FormFieldRepresentable {

    // MARK: - Public Properties

    /// Indicates whether validation should ignore the field and SwiftUI should remove its content from layout.
    public var isHidden: Bool
    /// Indicates whether validation and user interaction are disabled for the field.
    public var isDisabled: Bool
    /// The validation rules evaluated against ``value``.
    public var rules: [any FormFieldRule]
    /// An optional transformation applied whenever ``value`` is read.
    public var transform: ((Value) -> Value)?
    /// Indicates whether a SwiftUI field container should present validation errors.
    public var showErrors = false
    /// The transformed value captured at initialization and used by ``isModified``.
    public private(set) var originalValue: Value
    /// The current field value, transformed on reads when ``transform`` is present.
    public var value: Value {
        get {
            let rawValue = storedValue
            return transform?(rawValue) ?? rawValue
        }
        set {
            storedValue = newValue
            showErrors = true
        }
    }

    // MARK: - Private Properties

    private let initialValue: Value
    private var internalValue: Value
    private var externalValue: Binding<Value>?
    private var storedValue: Value {
        get { externalValue?.wrappedValue ?? internalValue }
        set {
            if let externalValue {
                externalValue.wrappedValue = newValue
            } else {
                internalValue = newValue
            }
        }
    }

    // MARK: - Initializer

    /// Creates a field synchronized with an external binding.
    ///
    /// - Parameters:
    ///   - value: The external source of the raw field value.
    ///   - isHidden: Whether the field starts hidden.
    ///   - isDisabled: Whether the field starts disabled.
    ///   - rules: The validation rules evaluated against the transformed value.
    ///   - transform: An optional transformation applied when reading the value.
    public init(
        _ value: Binding<Value>,
        isHidden: Bool = false,
        isDisabled: Bool = false,
        rules: [any FormFieldRule] = [],
        transform: ((Value) -> Value)? = nil
    ) {
        let initialValue = value.wrappedValue

        self.initialValue = initialValue
        self.internalValue = initialValue
        self.externalValue = value
        self.isHidden = isHidden
        self.isDisabled = isDisabled
        self.rules = rules
        self.transform = transform
        self.originalValue = transform?(initialValue) ?? initialValue
    }

    /// Creates a field backed by local storage.
    ///
    /// - Parameters:
    ///   - value: The initial raw value.
    ///   - isHidden: Whether the field starts hidden.
    ///   - isDisabled: Whether the field starts disabled.
    ///   - rules: The validation rules evaluated against the transformed value.
    ///   - transform: An optional transformation applied when reading the value.
    public init(
        _ value: Value,
        isHidden: Bool = false,
        isDisabled: Bool = false,
        rules: [any FormFieldRule] = [],
        transform: ((Value) -> Value)? = nil
    ) {
        self.initialValue = value
        self.internalValue = value
        self.isHidden = isHidden
        self.isDisabled = isDisabled
        self.rules = rules
        self.transform = transform
        self.originalValue = transform?(value) ?? value
    }

    // MARK: - Public Methods

    /// Restores the raw initial value and clears error presentation.
    public func reset() {
        storedValue = initialValue
        showErrors = false
    }

}
