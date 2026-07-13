# Validation Rule Workflows

## Rule contract and storage

Conform rules to `FormFieldRule` and implement `validate(_ value: Value?) throws`. Store heterogeneous rules directly in `FormField.rules`:

```swift
field.rules = [
    RequiredRule(ValidationError.required),
    EmailRule(ValidationError.invalidEmail)
]
```

Do not wrap rules in `AnyRule`. It is an internal adapter used only while the framework invokes existential rules.

`RequiredRule` rejects `nil` and `Emptable.isEmpty`. Other built-in rules pass `nil`, allowing optionality to be composed independently with `RequiredRule`. Preserve that convention unless a new rule explicitly documents different semantics.

## Built-in rule families

- Presence and format: `RequiredRule`, `EmailRule`.
- Fixed equality/order: `EqualRule`, `GreaterThanRule`, `GreaterThanOrEqualRule`, `LessThanRule`, `LessThanOrEqualRule`.
- Fixed collection membership: `ContainsRule`, `UniqueRule`.
- Measurement: `MinLengthRule`, `MaxLengthRule` using `Mensurable`.
- Dynamic cross-field/reference rules: matching `EqualKeyPathRule`, comparison `KeyPathRule`, `ContainsKeyPathRule`, and `UniqueKeyPathRule` types.

## Static rules

Use a static rule when the reference is fixed for the rule's lifetime. End its type name in `Rule`, accept `any Error`, pass `nil` unless the rule owns requiredness, and document the public API.

```swift
public struct EvenRule: FormFieldRule {
    private let error: any Error

    public init(_ error: any Error) {
        self.error = error
    }

    public func validate(_ value: Int?) throws {
        guard let value else { return }

        if !value.isMultiple(of: 2) {
            throw error
        }
    }
}
```

## KeyPath rules

Use a KeyPath rule when validation must read the current reference value on every invocation. End the type name in `KeyPathRule`, retain the root and key path, and apply the optional transform to the reference value or collection before comparison.

```swift
let rule = EqualKeyPathRule(
    credentials,
    keyPath: \.password,
    error: ValidationError.mismatch,
    transform: { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
)
```

Reference-type roots reflect later mutations dynamically. For value-type roots, the rule retains the value supplied at initialization.

## Tests and documentation

- Put each rule suite in `Tests/FormidableTests/Rules/<RuleName>Tests.swift`.
- Mark the suite `@MainActor` and use Swift Testing.
- Cover valid, invalid, and `nil` inputs; boundary equality for ordered rules; transforms and dynamic root updates for KeyPath rules.
- Name the file after the primary rule type and include `///` documentation with a compiling `# Example` for every public rule and initializer.
