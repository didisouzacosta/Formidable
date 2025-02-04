//
//  FormidableTests.swift
//  Formidable
//
//  Created by Adriano Costa on 29/01/25.
//

import Testing

@testable import Formidable

struct FormidableTests {
    
    @Test func ensureDefaultProperties() throws {
        let form = SignInForm(email: "", password: "")
        
        #expect(form.isValid)
        #expect(form.isModified == false)
        #expect(form.errors.isEmpty)
        #expect(form.fields.count == 2)
        
        try form.validate()
    }
    
    @Test func ensureIsModifiedWhenAnyFieldWasModified() throws {
        let form = SignInForm(email: "", password: "")
        
        #expect(form.isModified == false)
        
        form.emailField.value = "adrianosouzacostaios@gmail.com"
        
        #expect(form.isModified)
    }
    
    @Test func ensureIsValidWhenAllFieldsAreValid() throws {
        let form = SignInForm(email: "", password: "")
        form.emailField.rules = [RequiredRule(TestError.validationError)]
        form.passwordField.rules = [RequiredRule(TestError.validationError)]
        
        #expect(form.isValid == false)
        #expect(form.errors.count == 2)
        #expect(throws: TestError.validationError) {
            try form.validate()
        }
        
        form.emailField.value = "adrianosouzacostaios@gmail.com"
        form.passwordField.value = "1234567"
        
        #expect(form.isValid)
        #expect(form.errors.count == 0)
        
        try form.validate()
    }
    
    @Test func mustBeReturnToTheOriginalStateAfterReset() throws {
        let form = SignInForm(email: "email@gmail.com", password: "123")
        form.emailField.rules = [RequiredRule(TestError.validationError)]
        form.passwordField.rules = [RequiredRule(TestError.validationError)]
        
        #expect(form.isValid)
        
        form.emailField.value = ""
        form.passwordField.value = ""
        
        #expect(form.isValid == false)
        
        form.reset()
        
        #expect(form.isValid)
        #expect(form.emailField.value == "email@gmail.com")
        #expect(form.passwordField.value == "123")
    }
    
    @Test func disabledFieldsMustBeNotValidated() throws {
        let form = SignInForm(email: "", password: "123")
        
        form.emailField.rules = [RequiredRule(TestError.validationError)]
        form.emailField.isDisabled = true
        
        form.passwordField.rules = [RequiredRule(TestError.validationError)]
        
        #expect(form.isValid)
        
        form.emailField.isDisabled = false
        
        #expect(form.isValid == false)
    }
    
    @Test func hiddenFieldsMustBeNotValidated() throws {
        let form = SignInForm(email: "", password: "123")
        
        form.emailField.rules = [RequiredRule(TestError.validationError)]
        form.emailField.isHidden = true
        
        form.passwordField.rules = [RequiredRule(TestError.validationError)]
        
        #expect(form.isValid)
        
        form.emailField.isHidden = false
        
        #expect(form.isValid == false)
    }
    
}

fileprivate final class SignInForm: Formidable {
    
    // MARK: Public Variable
    
    var emailField: FormField<String>
    var passwordField: FormField<String>
    
    // MARK: - Initializers
    
    init(email: String, password: String) {
        self.emailField = .init(email)
        self.passwordField = .init(password)
    }
    
}
