//
//  FormFieldValue.swift
//  Formidable
//
//  Created by Adriano Costa on 23/01/25.
//

import SwiftUI

/// A generic class representing a form field with observable capabilities.
///
/// `FormFieldValue` is designed to manage the state, validation, and transformation of a form field's value.
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
/// let formField = FormFieldValue(
///     3,
///     rules: [GreaterThanRule(staticValue: 5, error: ValidationError.invalidValue)],
///     valueChanged: { oldValue, newValue in
///         print("Value changed from \(oldValue) to \(newValue)")
///     }
/// )
///
/// formField.isValid = false // Invalid
///
/// formField.value = 15 // Triggers `valueChanged` callback
///
///  formField.isValid = true // Valid
/// ```
///
/// ## Observability
/// The `@Observable` attribute enables observing changes to the `FormFieldValue` instance directly.
///
/// ## Use Cases
/// - Dynamic forms requiring value validation.
/// - Fields with conditional visibility or enabled state.
/// - Fields needing dynamic transformation of input values.
@Observable
public final class FormFieldValue<Value: Equatable>: FormField {
    
    // MARK: - Public Variables
    
    /// Indicates whether the field is hidden.
    public var isHidden: Bool
    
    /// Indicates whether the field is disabled.
    public var isDisabled: Bool
    
    /// A collection of validation rules to apply to the field's value.
    public var rules: [any FormFieldRule]
    
    /// An optional closure to transform the field's value dynamically.
    public var transform: ((Value) -> Value)?
    
    /// A closure that is triggered whenever the field's value changes.
    /// - Parameters:
    ///   - oldValue: The previous value of the field.
    ///   - newValue: The new value of the field.
    public var valueChanged: ((Value, Value) -> Void)?
    
    /// Indicates whether validation errors should be shown.
    public var showErrors = false
    
    /// The original value assigned to the field at initialization.
    public private(set) var originalValue: Value
    
    /// The current value of the field. The `transform` closure is applied if provided.
    public var value: Value {
        get { transform?(_value) ?? _value }
        set { _value = newValue }
    }
    
    // MARK: - Private Variables
    
    private var _value: Value {
        didSet {
            guard oldValue != value else { return }
            valueChanged?(oldValue, value)
            showErrors = true
        }
    }
    
    // MARK: - Life Cycle
    
    /// Initializes a new form field with the given parameters.
    ///
    /// - Parameters:
    ///   - value: The initial value of the field.
    ///   - isHidden: A flag indicating whether the field is initially hidden. Defaults to `false`.
    ///   - isDisabled: A flag indicating whether the field is initially disabled. Defaults to `false`.
    ///   - rules: A collection of validation rules to apply to the field's value. Defaults to an empty array.
    ///   - transform: An optional closure to transform the field's value dynamically. Defaults to `nil`.
    ///   - valueChanged: A closure triggered whenever the field's value changes. Defaults to `nil`.
    public init(
        _ value: Value,
        isHidden: Bool = false,
        isDisabled: Bool = false,
        rules: [any FormFieldRule] = [],
        transform: ((Value) -> Value)? = nil,
        valueChanged: ((Value, Value) -> Void)? = nil
    ) {
        self._value = value
        self.isHidden = isHidden
        self.isDisabled = isDisabled
        self.originalValue = value
        self.rules = rules
        self.transform = transform
        self.valueChanged = valueChanged
    }
}

