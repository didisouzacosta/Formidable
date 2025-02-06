//
//  RequirementsView.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 05/02/25.
//

import SwiftUI

struct RequirementsView: View {
    
    // MARK: - Private Properties
    
    private let nameIsValid: Bool
    private let emailIsValid: Bool
    private let passwordIsValid: Bool
    private let birthIsValid: Bool
    private let languageIsValid: Bool
    private let agreeTerms: Bool
    
    private var requiriments: [(label: String, status: Bool)] {
        [
            (label: "Valid name.", status: nameIsValid),
            (label: "Valid e-mail.", status: emailIsValid),
            (label: "Valid password.", status: passwordIsValid),
            (label: "To be legal age.", status: birthIsValid),
            (label: "Select a language.", status: languageIsValid),
            (label: "Agree terms.", status: agreeTerms)
        ]
    }
    
    // MARK: - Public Properties
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(requiriments, id: \.label) { requirement in
                HStack {
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 2)
                            .fill(requirement.status ? .green : .gray)
                            .frame(width: 8, height: 8)
                        Circle()
                            .fill(requirement.status ? .green : .clear)
                            .frame(width: 8, height: 8)
                    }
                    Text(requirement.label)
                        .strikethrough(requirement.status)
                }
            }
        }
    }
    
    // MARK: - Initilizers
    
    init(
        nameIsValid: Bool,
        emailIsValid: Bool,
        passwordIsValid: Bool,
        birthIsValid: Bool,
        languageIsValid: Bool,
        agreeTerms: Bool
    ) {
        self.nameIsValid = nameIsValid
        self.emailIsValid = emailIsValid
        self.passwordIsValid = passwordIsValid
        self.birthIsValid = birthIsValid
        self.languageIsValid = languageIsValid
        self.agreeTerms = agreeTerms
    }
    
}

#Preview {
    RequirementsView(
        nameIsValid: true,
        emailIsValid: false,
        passwordIsValid: false,
        birthIsValid: false,
        languageIsValid: false,
        agreeTerms: false
    )
}
