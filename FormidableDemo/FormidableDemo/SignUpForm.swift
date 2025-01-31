//
//  SignUpForm.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 30/01/25.
//

import Foundation
import Formidable

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
        nameField.rules = [RequiredRule(ValidationError.isRequired)]
        emailField.rules = [RequiredRule(ValidationError.isRequired)]
        passwordField.rules = [RequiredRule(ValidationError.isRequired)]
        birthField.rules = [RequiredRule(ValidationError.isRequired)]
    }
    
}

extension SignUpForm {
    
    enum ValidationError: LocalizedError {
        case isRequired
        case alreadyExists
        case weakPassword
        case minor
        
        var errorDescription: String? {
            switch self {
            case .isRequired: "This value must not be empty."
            case .alreadyExists: "This value already exists."
            case .weakPassword: "Input a strong password."
            case .minor: "You must be 18 years of age or older"
            }
        }
    }
    
}
