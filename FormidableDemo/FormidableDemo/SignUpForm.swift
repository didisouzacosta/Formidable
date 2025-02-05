//
//  SignUpForm.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 30/01/25.
//

import Foundation
import Formidable

@Observable
final class SignUpForm: Formidable {
    
    // MARK: - Public Variables
    
    var nameField: FormField<String>
    var emailField: FormField<String>
    var passwordField: FormField<String>
    var birthField: FormField<Date>
    
    // MARK: - Initializers
    
    init(_ user: User) {
        defer {
            setupRules()
        }
        
        self.nameField = .init(user.name)
        self.emailField = .init(user.email)
        self.passwordField = .init(user.password)
        self.birthField = .init(user.birthday)
    }
    
    // MARK: - Public Methods
    
    func submit() throws -> User {
        try validate()
        
        return .init(
            nameField.value,
            email: emailField.value,
            password: passwordField.value,
            birthday: birthField.value
        )
    }
    
    // MARK: - Private Methods
    
    private func setupRules() {
        nameField.rules = [
            RequiredRule(ValidationError.isRequired)
        ]
        
        emailField.rules = [
            EmailRule(ValidationError.validEmail),
            RequiredRule(ValidationError.isRequired)
        ]
        
        passwordField.rules = [
            RequiredRule(ValidationError.isRequired),
            MinLengthRule(3, error: ValidationError.minLengthPassword)
        ]
        
        birthField.rules = [
            RequiredRule(ValidationError.isRequired)
        ]
    }
    
}

extension SignUpForm {
    
    enum ValidationError: LocalizedError {
        case isRequired
        case validEmail
        case alreadyExists
        case weakPassword
        case minor
        case minLengthPassword
        
        var errorDescription: String? {
            switch self {
            case .isRequired: "This field cannot be left empty."
            case .validEmail: "Please enter a valid email address."
            case .alreadyExists: "This entry already exists."
            case .weakPassword: "Please enter a stronger password."
            case .minor: "You must be at least 18 years old."
            case .minLengthPassword: "Password must be at least 3 characters long."
            }
        }
    }
    
}
