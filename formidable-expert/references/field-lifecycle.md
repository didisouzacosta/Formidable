# FormField Lifecycle

## Storage and bindings

- Use `FormField(initialValue, ...)` for local storage.
- Use `FormField(binding, ...)` when the field must read from and write to an external source.
- Assigning through `FormField.value` writes through the active storage and sets `showErrors = true`.
- A direct mutation of the external source bypasses the `FormField.value` setter. It updates subsequent reads but does not enable `showErrors`.

## Transformations and original values

- Treat `transform` as deterministic normalization. Apply it when reading `value`; validation and modification checks therefore use the normalized value.
- Capture `originalValue` from the transformed initial value.
- Retain the raw initial value separately so `reset()` can restore raw storage without applying a non-idempotent transformation twice.
- After reset, reads apply `transform` exactly once and `showErrors` is false.

```swift
let field = FormField(
    "  Taylor  ",
    transform: { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
)

#expect(field.value == "Taylor")
field.value = "  Swift  "
#expect(field.showErrors)
field.reset()
#expect(field.value == "Taylor")
#expect(field.showErrors == false)
```

## Validation state

- `errors` evaluates every stored rule against the transformed value and preserves rule order.
- `isValid` is derived from `errors.isEmpty`.
- Hidden or disabled fields return no errors regardless of their value.
- `isModified` compares `value` with `originalValue`; changing visibility, disabled state, or `showErrors` does not modify the value.

## Tests

Add focused coverage in `Tests/FormidableTests/FormFieldTests.swift` for the affected transitions:

- initial and original values;
- local and external binding synchronization;
- direct external mutations versus field assignments;
- deterministic and non-idempotent transformations;
- `showErrors` after assignment and reset;
- raw reset behavior and `isModified`;
- hidden/disabled validation behavior.
