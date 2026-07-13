---
name: formidable-expert
description: Develop and review the Formidable Swift form-management framework and its SwiftUI integration. Use when working on Formidable, FormField, FormFieldRepresentable, Emptable, Mensurable, validation or KeyPath rules, Binding-backed and transformed fields, reset/validate state transitions, `.field` error presentation and accessibility, API compatibility, tests, or public documentation.
---

# Formidable Expert

Use the repository's `AGENTS.md` as the project-specific source of truth. Inspect the current implementation before changing behavior; report any discrepancy before altering a public contract.

## Workflow

1. Read `AGENTS.md`, the affected source, and its focused tests.
2. Load only the references needed for the task:
   - [references/forms.md](references/forms.md): form discovery, contracts, aggregate state, validation, and reset.
   - [references/field-lifecycle.md](references/field-lifecycle.md): local and external storage, transformations, modification state, and error visibility.
   - [references/rules.md](references/rules.md): built-in and custom static/KeyPath rule patterns.
   - [references/swiftui.md](references/swiftui.md): `.field`, accessibility, visibility, disabled state, and error presentation.
3. Preserve Swift 6.2 compatibility across iOS 17+, macOS 15+, and tvOS 17+.
4. Apply `$swift-mark-organization` to modified Swift files. Apply `$swiftui-expert-skill` to SwiftUI, Observation, animation, accessibility, or state-ownership work. Use the view-refactor or performance-audit skills only under the conditions in `AGENTS.md`.
5. Add focused Swift Testing coverage for every changed rule, contract, field, or form state transition.
6. Run `swift test` from the package root. Treat any documented test count as informational.

## Invariants

- Keep `Formidable` free of an actor-isolation requirement; isolate concrete app types only when their usage requires it.
- Preserve `FormFieldRepresentable: ObservableObject` compatibility while using `@Observable` for new observable reference types.
- Store rules directly as `[any FormFieldRule]`. Keep `AnyRule` internal and absent from call sites.
- Preserve field/rule order when collecting errors and throwing the first validation failure.
- Exclude hidden and disabled fields from validation.
- Keep public APIs documented with `///`; give public components a compiling `# Example`.
- Preserve source compatibility unless the requested change explicitly migrates a public contract.
