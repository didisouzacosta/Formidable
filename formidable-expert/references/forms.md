# Formidable Form Structure Guide

## Conforming to Formidable

Any class managing form fields should conform to `Formidable`.

- **Observable**: Must use `@Observable` (iOS 17+).
- **Properties**: Fields should be of type `FormField<Value>`.
- **Initialization**: Rules should be configured in the `init`, preferably within a `defer` block or a `setupRules()` method.

```swift
@Observable
final class MyForm: Formidable {
    var emailField: FormField<String>
    var ageField: FormField<Int>

    init(email: String = "", age: Int = 0) {
        self.emailField = FormField(email)
        self.ageField = FormField(age)
        
        defer { setupRules() }
    }

    private func setupRules() {
        emailField.rules = [RequiredRule(AppError.required), EmailRule(AppError.invalidEmail)]
        ageField.rules = [GreaterThanRule(18, error: AppError.underage)]
    }
}
```

## SwiftUI View Integration

Integration using the `.field()` View Modifier:

```swift
struct MyFormView: View {
    @State private var form = MyForm()

    var body: some View {
        Form {
            TextField("Email", text: $form.emailField.value)
                .field($form.emailField)

            Stepper("Age: \(form.ageField.value)", value: $form.ageField.value)
                .field($form.ageField)
        }
    }
}
```

## Form Operations

- **Validation**: `try form.validate()` (Throws the first error).
- **Reset**: `form.reset()` (Returns to the `originalValue` and clears errors).
- **Validity**: Use the `form.isValid` property.
- **Disabled State**: Control the entire form with `form.isDisabled`.
