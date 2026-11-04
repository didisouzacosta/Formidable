# Formidable - Project Standards and Rules (Codex)

This file is the project-specific source of truth for work in **Formidable**. The current implementation is the source of truth for runtime behavior; when it conflicts with this document, report the discrepancy before changing public behavior.

## Package Baseline

- Swift tools version: **6.2**.
- Supported platforms: **iOS 17+**, **macOS 15+**, and **tvOS 17+**.
- Preserve source and API compatibility across every supported platform. Gate platform-specific APIs with availability checks and provide an appropriate fallback.
- `Formidable` itself is not isolated to `@MainActor`. Do not describe or treat the protocol as actor-isolated unless the declaration is deliberately changed.
- New observable reference types should use Observation (`@Observable`). `FormFieldRepresentable` currently inherits from `ObservableObject`; preserve that compatibility requirement unless a dedicated migration changes the public contract.

## Architecture and Behavior

### Form contracts

- `Formidable` is the form-management protocol. Its default implementation uses `Mirror` to discover stored properties conforming to `FormFieldRepresentable`.
- `FormFieldRepresentable` is the field contract and exposes value, original value, visibility, disabled state, error visibility, transformation, and validation rules.
- `Emptable` represents values that can be checked for emptiness.
- `Mensurable` represents values with a numeric `length` measure.
- Use `FormField<Value>` for fields managed by a `Formidable` form.

### FormField behavior

- Assigning through `FormField.value` sets `showErrors = true`. `FormFieldContainer` decides whether and how those errors are rendered.
- A `FormField` initialized with `Binding<Value>` reads from and writes to the external source. A change made directly to that external source does not pass through the `FormField.value` setter and therefore does not automatically enable `showErrors`.
- `transform` normalizes the value returned to callers and used for validation. Keep transformations deterministic and cover their interaction with initialization and reset in tests.
- `originalValue` captures the transformed initial value and is used by `isModified`. `FormField` separately retains the raw initial value so a non-idempotent transformation is not applied twice during reset.
- `reset()` restores the raw initial value through the active binding or local storage and clears `showErrors`; reads continue to apply `transform` once.

### Validation

- Validation rules conform to `FormFieldRule` and are stored directly as `[any FormFieldRule]` in `FormField.rules`.
- `AnyRule` is an internal adapter used while validating existential rules; it is not the storage type exposed by `FormField` and must not be required at call sites.
- Static rules compare against a fixed value. Cross-field rules use a root object and `KeyPath` and end in `KeyPathRule`.
- `try form.validate()` enables error display for the form fields and throws the first collected error.
- Hidden or disabled fields produce no validation errors. A fully disabled form returns from validation without throwing.

### SwiftUI integration

- Apply `.field($form.field, accessibilityLabel: ...)` to standard SwiftUI controls to attach Formidable behavior.
- The modifier wraps the control in `FormFieldContainer`, applies hidden and disabled state, and renders localized error descriptions.
- Error presentation comes from the `FormFieldErrorStyle` stored in the Environment (`.formFieldErrorStyle(_:)`); `DefaultFormFieldErrorStyle` keeps the callout font and red color. `FormFieldContainer`, not the style, owns the accessibility element, label, and value of the messages.
- The error container must receive a meaningful, localizable accessibility label. Icon-only controls must also expose a meaningful accessibility label.

## Skills and Precedence

Use the canonical skill name to activate the skill; the linked path is the currently installed local reference.

- Use [$swiftui-expert-skill](/Users/adrianocosta/.agents/skills/swiftui-expert-skill/SKILL.md) when creating, reviewing, or modernizing SwiftUI code, including state ownership, Observation, concurrency, navigation, animation, accessibility, and modern API selection.
- Use [$swift-mark-organization](/Users/adrianocosta/.codex/skills/swift-mark-organization/SKILL.md) when creating, reviewing, refactoring, or normalizing Swift files. It owns exact `// MARK: -` names, member ordering, wrapper grouping, visibility, initializer layout, and modifier ordering.
- Use [$build-ios-apps:swiftui-view-refactor](/Users/adrianocosta/.codex/plugins/cache/openai-curated-remote/build-ios-apps/0.1.2/skills/swiftui-view-refactor/SKILL.md) when splitting a large view, tightening data flow, stabilizing view identity, or cleaning Observation ownership.
- Use [$build-ios-apps:swiftui-performance-audit](/Users/adrianocosta/.codex/plugins/cache/openai-curated-remote/build-ios-apps/0.1.2/skills/swiftui-performance-audit/SKILL.md) only for reported performance symptoms, an explicit performance audit, or a change to a known rendering hot path. Start with code review; request Instruments evidence only when code is inconclusive or runtime proof is required.

Resolve overlapping guidance in this order:

1. This file and verified Formidable behavior define project invariants.
2. `swift-mark-organization` defines Swift member and section organization.
3. `swiftui-expert-skill` defines modern SwiftUI, state, Observation, concurrency, and API practices.
4. `swiftui-view-refactor` defines view decomposition and data flow; its member-order guidance yields to `swift-mark-organization`.
5. `swiftui-performance-audit` defines the performance investigation and evidence workflow.

Additional conflict-resolution rules:

- Keep a trivial action inline when that is clearest. Extract non-trivial actions, side effects, and business logic from `body` into methods, services, or models.
- Prefer the MV pattern and vanilla SwiftUI. Do not introduce a view model merely to mirror local state or wrap environment dependencies; retain or add one only when the existing design or the requested feature genuinely requires it.
- Keep the view tree stable, pass only the inputs a subview needs, and prefer dedicated subview types for non-trivial sections over large computed `some View` fragments.
- Adopt Liquid Glass only when explicitly requested. Gate iOS 26+ APIs with `#available` and preserve suitable behavior on every supported platform.
- Versioned plugin-cache paths may change after a plugin upgrade. The canonical skill names remain the activation identifiers; update stale links when upgrading plugins.

## Swift Code Organization

- Apply the exact organization below to new or modified Swift declarations. Do not mass-reformat unrelated files solely to normalize their sections.
- Omit sections that do not apply, but keep the remaining sections in this order.
- Keep members in the same property-wrapper or visibility group contiguous. Preserve behavior while reorganizing.

For `View` types:

1. `// MARK: - Environments`
2. `// MARK: - Bindables`
3. `// MARK: - Bindings`
4. `// MARK: - App Storage`
5. `// MARK: - Scene Storage`
6. `// MARK: - Focus State`
7. `// MARK: - Gesture State`
8. `// MARK: - Namespaces`
9. `// MARK: - States`
10. `// MARK: - Public Properties`
11. `// MARK: - Body`
12. `// MARK: - Private Properties`
13. `// MARK: - Initializer`
14. `// MARK: - Public Methods`
15. `// MARK: - Private Methods`

For non-`View` types:

1. `// MARK: - Public Properties`
2. `// MARK: - Private Properties`
3. `// MARK: - Initializer`
4. `// MARK: - Public Methods`
5. `// MARK: - Private Methods`

## Naming, Layout, and Documentation

- Follow the existing source layout: `Contracts/`, `Rules/`, `Modifiers/`, `Components/`, and `Styles/`.
- Contract protocol names must end in `Representable`, `able`, or `ible`.
- Rule types must end in `Rule`; cross-field rule types must end in `KeyPathRule`.
- SwiftUI-style presentation protocols and their implementations live in `Styles/` and end in `Style`, following SwiftUI convention (for example `FormFieldErrorStyle`); their configuration types end in `StyleConfiguration`. The `Representable`/`able`/`ible` suffix rule applies to contract protocols only.
- A Swift file must match its primary type name. `FieldRule.swift` is a known legacy discrepancy for `FormFieldRule`; do not copy that mismatch into new files.
- Document every public type and public API with `///`. Include a compiling usage example under a `# Example` heading for public components.
- Keep view-owned `@State` and injected `@Bindable` properties private. Use `@State` to own an `@Observable` reference in a view and `@Bindable` only when the view needs bindings to an injected observable.
- Keep `body` simple and free of business logic. Use modern SwiftUI APIs and avoid unnecessary platform assumptions or fixed screen dimensions.

## Testing and Verification

- Use Swift Testing (`import Testing`, `@Test`, and `#expect`).
- Mark every test suite type with `@MainActor`. Helper types need actor isolation only when their usage requires it.
- Put rule tests in `Tests/FormidableTests/Rules/`, contract tests in `Tests/FormidableTests/Contracts/`, style tests in `Tests/FormidableTests/Styles/`, and shared field/form behavior tests in the corresponding top-level test file.
- Every new rule or contract behavior requires focused unit tests. Every changed field or form behavior must cover the affected state transitions.
- As applicable, test initial and original values, transformations, external binding synchronization, `showErrors`, `reset`, `isModified`, `isHidden`, `isDisabled`, error aggregation, and the first error thrown by `validate()`.
- Run the package verification command from the repository root:

```shell
swift test
```

- The established baseline at the time of this document revision is **91 tests in 24 suites**. Treat the count as informational rather than a substitute for a passing run.
