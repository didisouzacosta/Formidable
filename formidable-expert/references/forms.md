# Form and Contract Workflows

## Form architecture

- Conform the form-management type to `Formidable` and store managed inputs as `FormField<Value>` properties.
- Prefer `@Observable` for a new reference-type form. Do not add `@MainActor` merely because the type conforms to `Formidable`; add isolation only when the concrete app's usage requires it.
- Remember that the default `fields` implementation uses `Mirror` to discover stored `FormFieldRepresentable` properties in declaration order. Computed fields and nested fields are not discovered automatically.
- Configure rules directly in each field initializer when practical. Extract setup only when it materially improves clarity.

```swift
@Observable
final class SignInForm: Formidable {
    var email = FormField(
        "",
        rules: [
            RequiredRule(ValidationError.required),
            EmailRule(ValidationError.invalidEmail)
        ],
        transform: {
            $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        }
    )

    func submit() throws -> String {
        try validate()
        return email.value
    }
}
```

## Aggregate behavior

- `fields` returns discovered fields in stored-property order.
- `errors` flattens field errors while preserving field and rule order.
- `isValid` means the aggregate error list is empty.
- `isModified` becomes true when any field differs from its transformed original value.
- Reading `isDisabled` returns true only when every discovered field is disabled; assigning it updates every field.
- `try validate()` enables `showErrors` on every field and throws the first collected error. A fully disabled form returns without throwing.
- `reset()` dispatches through each field's concrete `reset()` witness; do not replace it with direct existential value assignment.

## Supporting contracts

- `FormFieldRepresentable` exposes value, original value, modification state, visibility, disabled state, error visibility, transformation, rules, and reset. Preserve its `ObservableObject` inheritance for compatibility.
- `Emptable` powers `RequiredRule`. Strings, data, and arrays use their native emptiness; `false` and numeric zero are empty; `Date` is never empty.
- `Mensurable` powers length rules. Strings/arrays/data use counts, numeric values use their numeric magnitude, and `Date` uses its time interval since 1970.

## Tests

- Put form aggregation and ordering tests in `Tests/FormidableTests/FormidableTests.swift`.
- Put contract tests in `Tests/FormidableTests/Contracts/`.
- Cover field discovery order, aggregate errors, first thrown error, whole-form disabling, reset dispatch, and hidden/disabled exclusions.
- Mark every test suite type `@MainActor` and use Swift Testing (`@Test`, `#expect`).
