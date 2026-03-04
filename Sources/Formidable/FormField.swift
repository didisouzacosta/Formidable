//
//  FormField.swift
//  Formidable
//
//  Created by Adriano Costa on 23/01/25.
//

import SwiftUI

/// A generic class representing a form field with observable capabilities.
///
/// `FormField` is designed to manage the state, validation, and transformation of a form field's value.
/// It supports observing changes to the value, applying validation rules, and transforming the value dynamically.
///
/// - Generic Parameter:
///   - `Value`: The type of the value contained in the form field, which must conform to `Equatable` for change detection.
///
/// ## Features
/// - Tracks changes to the field value.
/// - Supports optional value transformations.
/// - Allows validation using custom rules.
/// - Handles visibility and disabled states.
/// - Provides a callback for value change events.
///
/// ## Example Usage
///
/// ```swift
/// enum ValidationError: Error {
///     case invalidValue
/// }
///
/// let formField = FormField(
///     3,
///     rules: [GreaterThanRule(staticValue: 5, error: ValidationError.invalidValue)],
///     valueChange: { oldValue, newValue in
///         print("Value changed from \(oldValue) to \(newValue)")
///     }
/// )
///
/// formField.isValid = false // Invalid
///
/// formField.value = 15 // Triggers `valueChange` callback
///
///  formField.isValid = true // Valid
/// ```
///
/// ## Observability
/// The `@Observable` attribute enables observing changes to the `FormField` instance directly.
///
/// ## Use Cases
/// - Dynamic forms requiring value validation.
/// - Fields with conditional visibility or enabled state.
/// - Fields needing dynamic transformation of input values.

import SwiftUI

@Observable
public final class FormField<Value: Equatable>: FormFieldRepresentable {
    
    // MARK: - Public Variables
    
    /// Indicates whether the field is hidden.
    public var isHidden: Bool
    
    /// Indicates whether the field is disabled.
    public var isDisabled: Bool
    
    /// A collection of validation rules to apply to the field's value.
    public var rules: [any FormFieldRule]
    
    /// An optional closure to transform the field's value dynamically.
    public var transform: ((Value) -> Value)?
    
    /// Indicates whether validation errors should be shown.
    public var showErrors = false
    
    /// The original value assigned to the field at initialization.
    public private(set) var originalValue: Value
    
    /// The current value of the field. The `transform` closure is applied if provided.
    public var value: Value {
        get { transform?(_value) ?? _value }
        set {
            _value = newValue
            showErrors = true
        }
    }
    
    // MARK: - Private Variables
    
    private var _value: Value {
        get { _externalValue?.wrappedValue ?? _internalValue }
        set {
            if let _externalValue {
                _externalValue.wrappedValue = newValue
            } else {
                _internalValue = newValue
            }
        }
    }
    
    private var _internalValue: Value
    private var _externalValue: Binding<Value>?
    
    // MARK: - Initializers
    
    /// Initializes a new form field with an external binding.
    ///
    /// - Parameters:
    ///   - value: A `Binding` to the source value.
    ///   - isHidden: A flag indicating whether the field is initially hidden. Defaults to `false`.
    ///   - isDisabled: A flag indicating whether the field is initially disabled. Defaults to `false`.
    ///   - rules: A collection of validation rules to apply to the field's value. Defaults to an empty array.
    ///   - transform: An optional closure to transform the field's value dynamically. Defaults to `nil`.
    public init(
        _ value: Binding<Value>,
        isHidden: Bool = false,
        isDisabled: Bool = false,
        rules: [any FormFieldRule] = [],
        transform: ((Value) -> Value)? = nil
    ) {
        self._internalValue = value.wrappedValue
        self._externalValue = value
        self.isHidden = isHidden
        self.isDisabled = isDisabled
        self.originalValue = transform?(value.wrappedValue) ?? value.wrappedValue
        self.rules = rules
        self.transform = transform
    }
    
    /// Initializes a new form field with a local value.
    ///
    /// - Parameters:
    ///   - value: The initial value of the field.
    ///   - isHidden: A flag indicating whether the field is initially hidden. Defaults to `false`.
    ///   - isDisabled: A flag indicating whether the field is initially disabled. Defaults to `false`.
    ///   - rules: A collection of validation rules to apply to the field's value. Defaults to an empty array.
    ///   - transform: An optional closure to transform the field's value dynamically. Defaults to `nil`.
    public init(
        _ value: Value,
        isHidden: Bool = false,
        isDisabled: Bool = false,
        rules: [any FormFieldRule] = [],
        transform: ((Value) -> Value)? = nil
    ) {
        self._internalValue = value
        self.isHidden = isHidden
        self.isDisabled = isDisabled
        self.originalValue = transform?(value) ?? value
        self.rules = rules
        self.transform = transform
    }
    
}

