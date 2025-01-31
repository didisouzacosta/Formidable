//
//  User.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 30/01/25.
//

import Foundation

struct User {
    
    let name: String
    let email: String
    let password: String
    let birthday: Date
    
    init(
        _ name: String,
        email: String,
        password: String,
        birthday: Date
    ) {
        self.name = name
        self.email = email
        self.password = password
        self.birthday = birthday
    }
    
}

extension User {
    
    static let new: User = .init("", email: "", password: "", birthday: .now)
    
}
