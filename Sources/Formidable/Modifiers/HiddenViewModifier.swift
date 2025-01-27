//
//  HiddenViewModifier.swift
//  Formidable
//
//  Created by Adriano Costa on 24/01/25.
//

import SwiftUI

extension View {
    
    func isHidden(_ status: Bool) -> some View {
        modifier(HiddenViewModifier(status))
    }
    
}

struct HiddenViewModifier: ViewModifier {
    
    private let isHidden: Bool
    
    init(_ isHidden: Bool) {
        self.isHidden = isHidden
    }
    
    func body(content: Content) -> some View {
        if isHidden {
            EmptyView()
        } else {
            content
        }
    }
    
}
