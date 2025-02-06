//
//  SignUpFormView.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 30/01/25.
//

import SwiftUI
import Formidable

struct SignUpFormView: View {
    
    @State private var form = SignUpForm(.new)
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(
                        "Name",
                        text: $form.nameField.value
                    )
                    .field($form.nameField)
                    
                    TextField(
                        "E-mail",
                        text: $form.emailField.value
                    )
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .field($form.emailField)
                    
                    SecureField(
                        "Password",
                        text: $form.passwordField.value
                    )
                    .field($form.passwordField)
                }
                
                Section {
                    DatePicker(
                        "Birth",
                        selection: $form.birthField.value,
                        displayedComponents: .date
                    )
                    .field($form.birthField)
                    
                    Picker(
                        "Language",
                        selection: $form.languageField.value
                    ) {
                        ForEach(Language.allCases, id: \.self) { language in
                            Text(language.detail)
                        }
                    }
                    .field($form.languageField)
                }
                
                Section {
                    Toggle("Terms", isOn: $form.agreeTermsField.value)
                        .field($form.agreeTermsField)
                } footer: {
                    if !form.isDisabled {
                        RequirementsView(
                            nameIsValid: form.nameField.isValid,
                            emailIsValid: form.emailField.isValid,
                            passwordIsValid: form.passwordField.isValid,
                            birthIsValid: form.birthField.isValid,
                            languageIsValid: form.languageField.isValid,
                            agreeTerms: form.agreeTermsField.isValid
                        )
                        .padding(.top, 4)
                    }
                }
            }
            .navigationTitle("SignUp")
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: toggleDisable) {
                        Text(form.isDisabled ? "Enable" : "Disable")
                    }
                }
                ToolbarItemGroup() {
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
    
    private func toggleDisable() {
        form.isDisabled.toggle()
    }
    
    private func save() {
        do {
            let user = try form.submit()
            print(user)
        } catch {}
    }
    
}

#Preview {
    SignUpFormView()
}
