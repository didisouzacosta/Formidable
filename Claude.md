# Formidable - Project Standards & Rules (Claude)

This document defines the rules, architectural patterns, and conventions for development in the **Formidable** project, serving as a guide for the Claude assistant.

## 🏗️ Architecture & Design

- **SwiftUI & Concurrency**: The project uses modern SwiftUI with the `@Observable` macro (iOS 17+).
- **Protocol-Oriented Programming (POP)**:
    - `Formidable`: The main protocol for objects managing forms. It uses reflection (`Mirror`) to automatically discover properties conforming to `FormFieldRepresentable`.
    - `FormFieldRepresentable`: The base contract for any form field.
    - `Emptable`: Protocol for types that can be checked for emptiness (Strings, Arrays, Ints, etc.).
    - `Mensurable`: Protocol for types that have a "measure" or "length" (Double, Float, Date, String, etc.).
- **Generic Validation System**:
    - `FormFieldRule`: Base protocol for validation rules.
    - `AnyRule`: Type-eraser to allow heterogeneous collections of rules (`[any FormFieldRule]`).
    - Rules are divided into:
        - **Static**: Compare the value against a fixed value (e.g., `RequiredRule`, `EqualRule`).
        - **Dynamic (KeyPath)**: Compare the value against another property via `KeyPath` (e.g., `EqualKeyPathRule`, `GreaterThanKeyPathRule`).

## 📋 Implementation Rules

### FormField
- Always use the `FormField<Value>` class to represent form fields.
- **Auto-error Display**: `FormField` displays errors automatically as soon as its value changes (`didSet` on the internal `_value` property).
- **Transformations**: Use the `transform` closure to normalize data before validation/retrieval.
- **Original Value**: `FormField` maintains the original value to support `reset()` operations.

### Validation
- Rules must be injected into the `rules` property of the `FormField`.
- Manual validation occurs via `try form.validate()`, which throws the first error found.
- `isHidden` or `isDisabled` fields are ignored during validation.

### SwiftUI Integration
- Use the `.field($form.field)` modifier to inject form behavior into standard SwiftUI views (like `TextField`, `Picker`, etc.).
- This modifier wraps the view in a `FormFieldContainer`, which manages the display of error messages below the component.

## ✍️ Code Conventions

- **File Organization**:
    - Use `// MARK: -` to separate sections (Variables, Initialization, Methods, etc.).
    - Follow the existing folder structure: `Contracts/`, `Rules/`, `Modifiers/`, `Components/`.
- **Naming**:
    - Contract protocols must end in `Representable`, `able`, or `ible`.
    - Rules must end in `Rule` (or `KeyPathRule` if applicable).
    - Rule files must have the same name as the struct/class (note the discrepancy in `FieldRule.swift` vs `FormFieldRule`).
- **Documentation**:
    - All public components must include `///` documentation with usage examples (`# Example`).
- **Accessibility**:
    - Always provide an `accessibilityLabel` for the error container.

## 🧪 Testing
- Every new rule or contract feature must have corresponding unit tests in `Tests/FormidableTests/`.
- Test `reset`, `isModified`, `isHidden`, and `isDisabled` behaviors along with validation.
