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
    private let accessibilityLabel: String
    
    private var messages: [String] {
        (field.showErrors ? field.errors : []).map { $0.localizedDescription }
    }
    
    // MARK: - Life Cycle
    
    init(
        _ field: Binding<Form>,
        accessibilityLabel: String,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        _field = field
        
        self.accessibilityLabel = accessibilityLabel
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            content()
            
            if !messages.isEmpty {
                VStack(alignment: .leading) {
                    ForEach(Array(zip(messages.indices, messages)), id: \.0) { index, message in
                        Text(message)
                            .id(index)
                    }
                }
                .font(.callout)
                .foregroundStyle(.red)
                .accessibilityLabel(accessibilityLabel)
            }
        }
        .disabled(field.isDisabled)
        .isHidden(field.isHidden)
    }
    
}
