//
//  HiddenViewModifier.swift
//  Formidable
//
//  Created by Adriano Costa on 24/01/25.
//

import SwiftUI

extension View {

    // MARK: - Public Methods

    func isHidden(_ status: Bool) -> some View {
        modifier(HiddenViewModifier(status))
    }

}

struct HiddenViewModifier: ViewModifier {

    // MARK: - Public Properties

    private let isHidden: Bool

    // MARK: - Initializer

    init(_ isHidden: Bool) {
        self.isHidden = isHidden
    }

    // MARK: - Public Methods

    func body(content: Content) -> some View {
        if !isHidden {
            content
        }
    }

}
