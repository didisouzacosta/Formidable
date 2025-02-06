//
//  Language.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 05/02/25.
//

import Formidable

enum Language: String, CaseIterable {
    case none, portuguese, english, spanish
}

extension Language {
    
    var detail: String {
        rawValue.capitalized
    }
    
}

extension Language: Emptable {
    
    var isEmpty: Bool {
        switch self {
        case .none: true
        default: false
        }
    }
    
}
