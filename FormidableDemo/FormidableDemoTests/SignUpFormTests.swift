//
//  SignUpFormTests.swift
//  FormidableDemoTests
//
//  Created by Adriano Costa on 06/02/25.
//

import Foundation
import Testing

@testable import Formidable_Demo

@MainActor
struct SignUpFormTests {

    @Test func nameIsRequired() {
        let form = SignUpForm(.new)

        form.nameField.value = ""
        #expect(form.nameField.isValid == false)

        form.nameField.value = "Orlando"
        #expect(form.nameField.isValid)
    }

    @Test func emailIsRequiredAndMustBeValid() {
        let form = SignUpForm(.new)

        form.emailField.value = ""
        #expect(form.emailField.errors.first?.localizedDescription == SignUpForm.ValidationError.isRequired.localizedDescription)

        form.emailField.value = "invalid_email"
        #expect(form.emailField.errors.first?.localizedDescription == SignUpForm.ValidationError.validEmail.localizedDescription)

        form.emailField.value = "orlando@example.com"
        #expect(form.emailField.isValid)
    }

    @Test func passwordIsRequiredAndUsesMinimumLength() {
        let form = SignUpForm(.new)

        form.passwordField.value = ""
        #expect(form.passwordField.errors.first?.localizedDescription == SignUpForm.ValidationError.isRequired.localizedDescription)

        form.passwordField.value = "1234567"
        #expect(form.passwordField.errors.first?.localizedDescription == SignUpForm.ValidationError.minLengthPassword.localizedDescription)

        form.passwordField.value = "12345678"
        #expect(form.passwordField.isValid)
    }

    @Test func languageIsRequired() {
        let form = SignUpForm(.new)

        form.languageField.value = .none
        #expect(form.languageField.isValid == false)

        form.languageField.value = .english
        #expect(form.languageField.isValid)
    }

    @Test func initialLanguageComesFromUser() {
        let user = User(
            "Taylor",
            email: "taylor@example.com",
            password: "12345678",
            birthday: .distantPast,
            language: .spanish
        )

        let form = SignUpForm(user)

        #expect(form.languageField.value == .spanish)
        #expect(form.languageField.isModified == false)
    }

    @Test func birthdayRequiresLegalAge() {
        let currentDate = Date(timeIntervalSince1970: 1_767_225_600)
        let form = SignUpForm(.new, currentDate: currentDate)

        form.birthField.value = currentDate.subtracting(years: 17)
        #expect(form.birthField.isValid == false)

        form.birthField.value = currentDate.subtracting(years: 18)
        #expect(form.birthField.isValid)
    }

    @Test func termsMustBeAccepted() {
        let form = SignUpForm(.new)

        form.agreeTermsField.value = false
        #expect(form.agreeTermsField.isValid == false)

        form.agreeTermsField.value = true
        #expect(form.agreeTermsField.isValid)
    }

    @Test func invalidSubmitThrowsFirstErrorAndEnablesPresentation() {
        let form = SignUpForm(.new)

        #expect(throws: SignUpForm.ValidationError.isRequired) {
            try form.submit()
        }

        #expect(form.fields.allSatisfy { $0.showErrors })
    }

    @Test func validSubmitReturnsNormalizedUser() throws {
        let currentDate = Date(timeIntervalSince1970: 1_767_225_600)
        let form = makeValidForm(currentDate: currentDate)
        form.nameField.value = "  Adriano Costa  "
        form.emailField.value = "  ADRIANO@EXAMPLE.COM  "

        let user = try form.submit()

        #expect(user.name == "Adriano Costa")
        #expect(user.email == "adriano@example.com")
        #expect(user.password == "12345678")
        #expect(user.birthday == currentDate.subtracting(years: 18).zeroSeconds())
        #expect(user.language == .portuguese)
    }

    @Test func resetRestoresInitialValuesAndClearsErrors() {
        let initialUser = User(
            "  Taylor  ",
            email: "TAYLOR@EXAMPLE.COM",
            password: "12345678",
            birthday: .distantPast,
            language: .english
        )
        let form = SignUpForm(initialUser)

        form.nameField.value = "Updated"
        form.emailField.value = "updated@example.com"
        form.languageField.value = .spanish
        form.reset()

        #expect(form.nameField.value == "Taylor")
        #expect(form.emailField.value == "taylor@example.com")
        #expect(form.languageField.value == .english)
        #expect(form.isModified == false)
        #expect(form.fields.allSatisfy { $0.showErrors == false })
    }

    // MARK: - Private Methods

    private func makeValidForm(currentDate: Date) -> SignUpForm {
        let form = SignUpForm(.new, currentDate: currentDate)
        form.nameField.value = "Adriano"
        form.emailField.value = "adriano@example.com"
        form.passwordField.value = "12345678"
        form.birthField.value = currentDate.subtracting(years: 18)
        form.languageField.value = .portuguese
        form.agreeTermsField.value = true
        return form
    }

}
