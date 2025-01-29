//
//  FormFieldContainer.swift
//  Formidable
//
//  Created by Adriano Costa on 15/01/25.
//

import SwiftUI

struct FormFieldContainer<Content: View, Form: FormFieldRepresentable>: View {
    
    // MARK: - Private Variables
    
    @Binding private var field: Form
    
    private let content: () -> Content
    
    private var errors: [Error] {
        field.showErrors ? field.errors : []
    }
    
    // MARK: - Life Cycle
    
    init(
        _ field: Binding<Form>,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        _field = field
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            content()
            TextErrors(field.showErrors ? field.errors : [])
        }
        .disabled(field.isDisabled)
        .isHidden(field.isHidden)
    }
    
}
