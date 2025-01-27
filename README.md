# Formidable

The `Formidable` protocol is designed for objects that manage forms composed of multiple `FormField` components. By conforming to this protocol, you can leverage built-in functionality to validate, reset, and check the validity of all form fields at once.

#### Key Features:

- **Validation**: The `validate()` method validates all fields in the form and throws an error if any field fails validation.
- **Reset**: The `reset()` method resets all fields back to their original values.
- **Validity Check**: The `isValid` computed property checks if all fields are valid by confirming there are no validation errors.
- **Error Aggregation**: The `errors` computed property collects all errors from the form fields, so you can handle them collectively.

By adopting `Formidable`, you can create complex forms with ease, ensuring their correctness and consistency throughout the application lifecycle.

# FormField System

This system provides a structure for managing form fields, performing validation, and handling user inputs in a consistent manner. The `FormField` protocol and various rule types enable creating dynamic and flexible forms for iOS applications.

## Table of Contents

- [FormFieldValue](#formfieldvalue)
- [Formidable Protocol](#formidable-protocol)
- [Validation Rules](#validation-rules)
- [Example Usage](#example-usage)

---

### FormFieldValue

The `FormFieldValue` class represents a form field with a specific value. It is responsible for holding the value, applying validation rules, and triggering value changes.

#### Public Variables

- **`isHidden`**: A boolean indicating whether the field should be hidden from the UI. Default is `false`.
- **`isDisabled`**: A boolean indicating whether the field should be disabled (i.e., not editable). Default is `false`.
- **`rules`**: An array of validation rules that should be applied to the field. This is an array of types conforming to the `FormFieldRule` protocol.
- **`transform`**: An optional closure that can be used to transform the value before accessing it.
- **`valueChanged`**: A closure that is called when the value of the field changes. It provides both the old and new values.
- **`showErrors`**: A boolean that determines whether validation errors should be displayed for the field. Default is `false`.
- **`originalValue`**: The original value of the field when it was first created. This is used to reset the field to its initial value.
- **`value`**: The current value of the field. This is the value that can be accessed and modified. The getter applies the `transform` closure (if provided) to the value.

---

### Formidable Protocol

The `Formidable` protocol is intended for objects that contain one or more `FormField` objects. It provides functionality for validating fields, resetting them, and managing errors.

#### Public Methods

- **`validate()`**: This method validates all form fields. If any field fails validation, an error is thrown. It first sets `showErrors` to `true` for each field before performing validation.
- **`reset()`**: Resets all form fields to their original values and clears any validation errors.
- **`isValid`**: A computed property that returns `true` if all fields are valid (i.e., no errors), and `false` otherwise.
- **`errors`**: A computed property that returns an array of errors from all form fields.

#### Private Properties

- **`fields`**: A computed property that uses reflection to dynamically find and return all properties of the conforming object that are of type `FormField`.

---

### Validation Rules

Validation rules are used to define the conditions that form fields must meet to be considered valid. Some common rules include `GreaterThanRule`, `LessThanRule`, `RequiredRule`, and `EqualRule`. These rules can be added to form fields to validate their values according to the defined logic.

For example, you can set a rule to ensure that a field’s value is greater than a specific value or that it is required to be non-empty.

---

### Example Usage

Below is an example of how to use the form system with the `Formidable` protocol and `FormFieldValue` class, along with validation rules.

```swift
@Observable
struct UserForm: Formidable {
    var name: FormFieldValue<String>
    var age: FormFieldValue<Int>
    
    init(name: String, age: Int) {
        self.name = FormFieldValue(name)
        self.age = FormFieldValue(age)
    }
}

// Create the form with initial values
let form = UserForm(name: "John", age: 25)

// Add validation rules to the form fields
form.name.rules = [RequiredRule(EmptyValueError())]
form.age.rules = [GreaterThanRule(18, error: AgeTooLowError())]

// Perform validation
do {
    try form.validate()
    print("Form is valid!")
} catch {
    print("Validation failed: \(error)")
}

// Reset the form fields to their original values
form.reset()
