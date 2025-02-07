//
//  SignUpFormTests.swift
//  FormidableDemoTests
//
//  Created by Adriano Costa on 06/02/25.
//

import Testing
import Foundation

@testable import Formidable_Demo

struct SignUpFormTests {
    
    @Test func nameFieldMustBeRequired() async throws {
        let form = SignUpForm(.new)
        
        form.nameField.value = ""
        
        #expect(form.nameField.isValid == false)
        
        form.nameField.value = "Orlando"
        
        #expect(form.nameField.isValid)
    }
    
    @Test func emailFieldMustContainAValidEmail() async throws {
        let form = SignUpForm(.new)
        
        form.emailField.value = "invalid_email"
        
        #expect(form.emailField.isValid == false)
        
        form.emailField.value = "orlando@gmail.com"
        
        #expect(form.emailField.isValid)
    }
    
    @Test func passwordFieldMustBeRequired() async throws {
        let form = SignUpForm(.new)
        
        form.passwordField.value = ""
        
        let requiredDescription = SignUpForm.ValidationError.isRequired.errorDescription
        
        #expect(form.passwordField.errors.contains(where: { $0.localizedDescription == requiredDescription }))
        #expect(form.passwordField.isValid == false)
        
        form.passwordField.value = "123"
        
        #expect(form.passwordField.isValid)
    }
    
    @Test func passwordFieldMustContainAtLeastTreeCharacters() async throws {
        let form = SignUpForm(.new)
        
        form.passwordField.value = "12"
        
        let minLengthPasswordDescription = SignUpForm.ValidationError.minLengthPassword.errorDescription
        
        #expect(form.passwordField.errors.contains(where: { $0.localizedDescription == minLengthPasswordDescription }))
        #expect(form.passwordField.isValid == false)
        
        form.passwordField.value = "123"
        
        #expect(form.passwordField.isValid)
        #expect(form.passwordField.errors.count == 0)
    }
    
    @Test func languageFieldMustBeRequired() async throws {
        let form = SignUpForm(.new)
        
        form.languageField.value = .none
        
        #expect(form.languageField.isValid == false)
        
        form.languageField.value = .english
        
        #expect(form.languageField.isValid)
    }
    
    @Test func birthFieldShouldNotBeLessThan18Years() async throws {
        let form = SignUpForm(.new)
        
        form.birthField.value = Date.now.remove(years: 17)
        
        #expect(form.birthField.isValid == false)
        
        form.birthField.value = Date.now.remove(years: 18)
        
        #expect(form.birthField.isValid)
    }
    
    @Test func agreeTermsFieldMustBeRequired() async throws {
        let form = SignUpForm(.new)
        
        form.agreeTermsField.value = false
        
        #expect(form.agreeTermsField.isValid == false)
        
        form.agreeTermsField.value = true
        
        #expect(form.agreeTermsField.isValid)
    }
    
    @Test func formShouldThrowAnErrorWhenAnyFieldIsInvalid() throws {
        let form = SignUpForm(.new)
        
        #expect(throws: SignUpForm.ValidationError.isRequired) {
            try form.submit()
        }
    }
    
    @Test func formMustReturnUserWhenItsValid() throws {
        let form = SignUpForm(.new)
        form.nameField.value = "Adriano"
        form.emailField.value = "adriano@gmail.com"
        form.passwordField.value = "123"
        form.languageField.value = .portuguese
        form.agreeTermsField.value = true
        
        let user = try form.submit()
        
        #expect(user.name == "Adriano")
        #expect(user.email == "adriano@gmail.com")
        #expect(user.password == "123")
        #expect(user.birthday == Date.now.remove(years: 18).zeroSeconds())
        #expect(user.language == .portuguese)
    }

}
