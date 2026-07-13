//
//  RequirementsView.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 05/02/25.
//

import SwiftUI

struct RequirementsView: View {

    // MARK: - Public Properties

    private let nameIsValid: Bool
    private let emailIsValid: Bool
    private let passwordIsValid: Bool
    private let birthIsValid: Bool
    private let languageIsValid: Bool
    private let agreeTermsIsValid: Bool

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(requirements) { requirement in
                Label {
                    Text(requirement.label)
                        .strikethrough(requirement.isSatisfied)
                } icon: {
                    Image(systemName: requirement.isSatisfied ? "checkmark.circle.fill" : "circle")
                }
                .foregroundStyle(requirement.isSatisfied ? .green : .secondary)
                .accessibilityElement(children: .combine)
                .accessibilityLabel(Text(requirement.label))
                .accessibilityValue(requirement.accessibilityValue)
            }
        }
    }

    // MARK: - Private Properties

    private var requirements: [Requirement] {
        [
            Requirement(id: .name, label: "Enter a name", isSatisfied: nameIsValid),
            Requirement(id: .email, label: "Enter a valid email", isSatisfied: emailIsValid),
            Requirement(id: .password, label: "Use at least 8 password characters", isSatisfied: passwordIsValid),
            Requirement(id: .birth, label: "Be at least 18 years old", isSatisfied: birthIsValid),
            Requirement(id: .language, label: "Select a language", isSatisfied: languageIsValid),
            Requirement(id: .terms, label: "Accept the terms", isSatisfied: agreeTermsIsValid)
        ]
    }

    // MARK: - Initializer

    init(
        _ nameIsValid: Bool,
        emailIsValid: Bool,
        passwordIsValid: Bool,
        birthIsValid: Bool,
        languageIsValid: Bool,
        agreeTermsIsValid: Bool
    ) {
        self.nameIsValid = nameIsValid
        self.emailIsValid = emailIsValid
        self.passwordIsValid = passwordIsValid
        self.birthIsValid = birthIsValid
        self.languageIsValid = languageIsValid
        self.agreeTermsIsValid = agreeTermsIsValid
    }

}

fileprivate struct Requirement: Identifiable {

    // MARK: - Public Properties

    let id: ID
    let label: LocalizedStringKey
    let isSatisfied: Bool

    // MARK: - Private Properties

    fileprivate var accessibilityValue: Text {
        let value: LocalizedStringKey = isSatisfied ? "Completed" : "Incomplete"
        return Text(value)
    }

    enum ID: Hashable {
        case name
        case email
        case password
        case birth
        case language
        case terms
    }

}

#Preview {
    RequirementsView(
        true,
        emailIsValid: false,
        passwordIsValid: false,
        birthIsValid: false,
        languageIsValid: false,
        agreeTermsIsValid: false
    )
    .padding()
}
