# Formidable

`Formidable` is a protocol designed for objects that manage forms composed of multiple `FormField` components. It provides built-in functionality for validating, resetting, and checking the validity of form fields.

https://github.com/user-attachments/assets/2aab4a21-b7ff-4526-a73b-7bba02a7f070

## Key Features
- **Validation**: The `validate()` method checks all fields and throws an error if any fail validation.
- **Reset**: The `reset()` method restores all fields to their original values.
- **Validity Check**: The `isValid` computed property determines whether all fields are valid.
- **Error Aggregation**: The `errors` computed property collects validation errors for easy handling.
- **Enable State**: The `isEnabled` property checks whether all fields are enabled.

By adopting `Formidable`, you can create structured forms with reliable state management and validation.

---

## FormField

The `FormField` class represents a form field, managing its value, validation rules, and change tracking.

### Public Properties
- **`isHidden`**: Hides the field from the UI (default: `false`).
- **`isDisabled`**: Disables editing (default: `false`).
- **`rules`**: An array of validation rules (`FormFieldRule` conforming types).
- **`transform`**: An optional closure that modifies the value before retrieval.
- **`valueChanged`**: A closure triggered when the value changes.
- **`showErrors`**: Controls whether validation errors should be displayed.
- **`originalValue`**: Stores the initial value for reset purposes.
- **`value`**: Holds the current field value, applying transformations if set.

---

## Instalation

### Swift Package Manager

```
https://github.com/didisouzacosta/Formidable
```

---

## Example Usage

```swift
import SwiftUI
import Formidable

enum ValidationError: LocalizedError {
    case isRequired
    case ageTooLow

    var errorDescription: String? {
        switch self {
        case .isRequired: return "This field cannot be left empty."
        case .ageTooLow: return "You need to be of legal age."
        }
    }
}

@Observable
final class UserForm: Formidable {
    
    // MARK: - Public Properties
    
    var nameField: FormField<String>
    var ageField: FormField<Int>
    
    // MARK: - Initialization
    
    init(_ name: String, age: Int) {
        nameField = FormField(name)
        ageField = FormField(age)
        
        defer {
            setupRules()
        }
    }
    
    // MARK: - Public Methods
    
    func submit() throws -> (name: String, age: Int) {
        try validate()
        return (name: nameField.value, age: ageField.value)
    }
    
    // MARK: - Private Methods
    
    private func setupRules() {
        nameField.rules = [RequiredRule(ValidationError.isRequired)]
        ageField.rules = [GreaterThanRule(18, error: ValidationError.ageTooLow)]
    }
}

struct UserFormView: View {
    
    @State private var form = UserForm("", age: 0)
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $form.nameField.value)
                        .field($form.nameField)
                    
                    Picker("Age", selection: $form.ageField.value) {
                        ForEach([10, 18, 36], id: \.self) { age in
                            Text("\(age)")
                        }
                    }
                    .field($form.ageField)
                }
            }
            .navigationTitle("User")
            .toolbar {
                ToolbarItemGroup {
                    Button(action: reset) {
                        Text("Reset")
                    }
                    .disabled(form.isDisabled)
                    
                    Button(action: save) {
                        Text("Save")
                    }
                }
            }
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func reset() {
        form.reset()
    }
    
    private func save() {
        do {
            let data = try form.submit()
            print(data)
        } catch {
            print(error)
        }
    }
}

#Preview {
    UserFormView()
}
```