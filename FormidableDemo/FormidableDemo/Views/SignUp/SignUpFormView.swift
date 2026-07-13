//
//  SignUpFormView.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 30/01/25.
//

import Formidable
import SwiftUI

struct SignUpFormView: View {

    // MARK: - States

    @State private var form = SignUpForm(.new)
    @State private var submissionFeedback: SubmissionFeedback?

    // MARK: - Body

    var body: some View {
        NavigationStack {
            Form {
                Section("Account") {
                    TextField(
                        "Name",
                        text: $form.nameField.value
                    )
                    .textContentType(.name)
                    .field(
                        $form.nameField,
                        accessibilityLabel: "Name errors"
                    )

                    TextField(
                        "Email",
                        text: $form.emailField.value
                    )
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .field(
                        $form.emailField,
                        accessibilityLabel: "Email errors"
                    )

                    SecureField(
                        "Password",
                        text: $form.passwordField.value
                    )
                    .textContentType(.newPassword)
                    .field(
                        $form.passwordField,
                        accessibilityLabel: "Password errors"
                    )
                }

                Section("Profile") {
                    DatePicker(
                        "Birthday",
                        selection: $form.birthField.value,
                        displayedComponents: .date
                    )
                    .field(
                        $form.birthField,
                        accessibilityLabel: "Birthday errors"
                    )

                    Picker(
                        "Language",
                        selection: $form.languageField.value
                    ) {
                        ForEach(Language.allCases, id: \.self) { language in
                            Text(language.title)
                                .tag(language)
                        }
                    }
                    .field(
                        $form.languageField,
                        accessibilityLabel: "Language errors"
                    )
                }

                Section {
                    Toggle(
                        "I agree to the terms",
                        isOn: $form.agreeTermsField.value
                    )
                    .field(
                        $form.agreeTermsField,
                        accessibilityLabel: "Terms errors"
                    )
                } header: {
                    Text("Consent")
                } footer: {
                    RequirementsView(
                        form.nameField.isValid,
                        emailIsValid: form.emailField.isValid,
                        passwordIsValid: form.passwordField.isValid,
                        birthIsValid: form.birthField.isValid,
                        languageIsValid: form.languageField.isValid,
                        agreeTermsIsValid: form.agreeTermsField.isValid
                    )
                    .padding(.top, 4)
                }
            }
            .navigationTitle("Sign Up")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Reset", systemImage: "arrow.counterclockwise", action: reset)
                        .disabled(!form.isModified)
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", systemImage: "checkmark", action: save)
                }
            }
            .alert(item: $submissionFeedback) { feedback in
                Alert(
                    title: Text(feedback.title),
                    message: Text(verbatim: feedback.message),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    // MARK: - Private Methods

    private func reset() {
        submissionFeedback = nil
        form.reset()
    }

    private func save() {
        do {
            let user = try form.submit()
            submissionFeedback = SubmissionFeedback(
                "Account ready",
                message: "Welcome, \(user.name)!"
            )
        } catch {
            submissionFeedback = SubmissionFeedback(
                "Check the form",
                message: error.localizedDescription
            )
        }
    }

}

fileprivate struct SubmissionFeedback: Identifiable {

    // MARK: - Public Properties

    let id = UUID()
    let title: LocalizedStringKey
    let message: String

    // MARK: - Initializer

    init(_ title: LocalizedStringKey, message: String) {
        self.title = title
        self.message = message
    }

}

#Preview {
    SignUpFormView()
}
