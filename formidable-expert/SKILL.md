---
name: formidable-expert
description: Expert in the Formidable framework for SwiftUI. Use when needing to create new validation rules, structure forms (conforming to Formidable), migrate fields to the FormField pattern, or implement reset/validation logic in the Formidable project.
---

# Formidable Expert Skill

This skill provides procedural guidance for developing and maintaining the **Formidable** framework.

## Quick Navigation

Follow the appropriate guide based on your task:

- **Create New Rules**: See [references/rules.md](references/rules.md) for `FormFieldRule` implementation patterns (Static vs KeyPath) and `AnyRule` usage.
- **Form Architecture**: See [references/forms.md](references/forms.md) for structuring classes that conform to `Formidable` and integrating with SwiftUI views.
- **Unit Testing**: Ensure every new rule has tests in `Tests/FormidableTests/Rules/` and every new field in `Tests/FormidableTests/FormFieldTests.swift`.

## Core Concepts

- **FormField<Value>**: The main `@Observable` class that manages value, rules, and error state.
- **Validation Flow**: `FormField` displays errors in the internal value's `didSet`. The form's `validate()` method triggers `showErrors = true` for all fields.
- **Transformation**: Use the `transform` parameter in the `FormField` init to normalize data (e.g., `trimmingCharacters`, `uppercased`).

## Code Standards

- Always use `// MARK: -` to organize code sections.
- All public components must include `///` documentation with `# Example` examples.
- Contract protocols must end in `Representable`, `able`, or `ible`.
- Rules must end in `Rule`.
