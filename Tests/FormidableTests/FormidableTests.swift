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
        #expect(form.errors.isEmpty)
        #expect(form.fields.count == 2)
        
        try form.validate()
    }
    
}

fileprivate struct Login {
    
    let email: String
    let password: String
    
    init(_ email: String, password: String) {
        self.email = email
        self.password = password
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
    
    // MARK: - Public Methods
    
    func submit() throws -> Login {
        try validate()
        
        return .init(
            emailField.value,
            password: passwordField.value
        )
    }
    
}
