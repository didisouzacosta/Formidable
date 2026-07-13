# SwiftUI Integration

## Attaching a field

Apply `.field(_:accessibilityLabel:)` to a standard SwiftUI control. Pass a meaningful, localizable error label rather than relying on the generic default in production UI.

```swift
TextField("Email", text: $form.email.value)
    .textInputAutocapitalization(.never)
    .field($form.email, accessibilityLabel: "Email errors")
```

The modifier wraps the control in `FormFieldContainer`, applies the field's hidden and disabled state, and presents each localized validation error below the control. Icon-only controls must also expose a meaningful accessibility label for the control itself.

## Error presentation

Keep error presentation synchronous with validation state:

- Derive `messages` from `showErrors` and `errors`.
- Render the derived messages directly in the conditional error stack.
- Do not introduce separate presentation state for errors.
- Do not apply `.animation`, `withAnimation`, `.transition`, or `.contentTransition` to error presentation.
- Add, replace, and remove messages immediately after editing, `validate()`, or `reset()` changes the field state.

Keep animation out of `FormField.value` and do not expose public animation parameters through `.field(...)`.

## Accessibility

- Combine error children into one accessibility element.
- Preserve the meaningful localizable label supplied by the caller.
- Expose the current derived localized messages as a combined accessibility value.
- Remove stale accessibility content when messages clear, the field resets, or validation becomes excluded.

## View conventions

- Keep view-owned `@State` and injected `@Bindable` properties private.
- Use `@State` to own an `@Observable` reference; use `@Bindable` only when an injected observable needs bindings.
- Keep `body` free of validation or business logic. Extract non-trivial state updates into private methods.
- Preserve stable view identity and supported-platform behavior; adopt Liquid Glass only when explicitly requested.
- Follow the exact `// MARK: -` ordering and modifier placement defined by `$swift-mark-organization` and `AGENTS.md`.

## Verification

Exercise the demo without animation:

- first error shown after editing or `validate()`;
- multiple messages and replacement with a different message set;
- correction and `reset()` removal;
- hidden and disabled fields;
- accessibility label and combined value updates.
