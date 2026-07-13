//
//  SignUpForm.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 30/01/25.
//

import Formidable
import Foundation

@Observable
@MainActor
final class SignUpForm: Formidable {

    // MARK: - Public Properties

    var nameField: FormField<String>
    var emailField: FormField<String>
    var passwordField: FormField<String>
    var birthField: FormField<Date>
    var languageField: FormField<Language>
    var agreeTermsField: FormField<Bool>

    // MARK: - Initializer

    init(_ user: User, currentDate: Date = .now) {
        self.nameField = FormField(
            user.name,
            rules: [RequiredRule(ValidationError.isRequired)],
            transform: { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        )
        self.emailField = FormField(
            user.email,
            rules: [
                RequiredRule(ValidationError.isRequired),
                EmailRule(ValidationError.validEmail)
            ],
            transform: {
                $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            }
        )
        self.passwordField = FormField(
            user.password,
            rules: [
                RequiredRule(ValidationError.isRequired),
                MinLengthRule(8, error: ValidationError.minLengthPassword)
            ]
        )
        self.birthField = FormField(
            user.birthday,
            rules: [
                LessThanOrEqualRule(
                    currentDate.subtracting(years: 18).zeroSeconds(),
                    error: ValidationError.toBeLegalAge
                )
            ],
            transform: { $0.zeroSeconds() }
        )
        self.languageField = FormField(
            user.language,
            rules: [RequiredRule(ValidationError.isRequired)]
        )
        self.agreeTermsField = FormField(
            false,
            rules: [RequiredRule(ValidationError.agreeTerms)]
        )
    }

    // MARK: - Public Methods

    func submit() throws -> User {
        try validate()

        return User(
            nameField.value,
            email: emailField.value,
            password: passwordField.value,
            birthday: birthField.value,
            language: languageField.value
        )
    }

}

extension SignUpForm {

    enum ValidationError: LocalizedError {
        case isRequired
        case validEmail
        case toBeLegalAge
        case minLengthPassword
        case agreeTerms

        var errorDescription: String? {
            switch self {
            case .isRequired: "This field cannot be left empty."
            case .validEmail: "Please enter a valid email address."
            case .toBeLegalAge: "You need to be at least 18 years old."
            case .minLengthPassword: "Password must be at least 8 characters long."
            case .agreeTerms: "You must accept the terms."
            }
        }
    }

}
