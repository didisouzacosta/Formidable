//
//  User.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 30/01/25.
//

import Foundation

struct User: Equatable {

    // MARK: - Public Properties

    let name: String
    let email: String
    let password: String
    let birthday: Date
    let language: Language

    // MARK: - Initializer

    init(
        _ name: String,
        email: String,
        password: String,
        birthday: Date,
        language: Language
    ) {
        self.name = name
        self.email = email
        self.password = password
        self.birthday = birthday
        self.language = language
    }

}

extension User {

    // MARK: - Public Properties

    static var new: User {
        User(
            "",
            email: "",
            password: "",
            birthday: Date.now.subtracting(years: 18),
            language: .none
        )
    }

}
