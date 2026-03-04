//
//  User.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 30/01/25.
//

import Foundation

struct User {
    
    var name: String
    var email: String
    var password: String
    var birthday: Date
    var language: Language
    
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
    
    static let new: User = .init(
        "",
        email: "",
        password: "",
        birthday: .now.remove(years: 18),
        language: .none
    )
    
}
