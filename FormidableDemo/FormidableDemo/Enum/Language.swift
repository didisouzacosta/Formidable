//
//  Language.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 05/02/25.
//

import Formidable
import SwiftUI

enum Language: String, CaseIterable {

    case none
    case portuguese
    case english
    case spanish

}

extension Language {

    // MARK: - Public Properties

    var title: LocalizedStringKey {
        switch self {
        case .none: "Select a language"
        case .portuguese: "Portuguese"
        case .english: "English"
        case .spanish: "Spanish"
        }
    }

}

extension Language: Emptable {

    // MARK: - Public Properties

    var isEmpty: Bool {
        self == .none
    }

}
