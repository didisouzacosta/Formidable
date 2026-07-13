//
//  FormFieldContainer.swift
//  Formidable
//
//  Created by Adriano Costa on 15/01/25.
//

import SwiftUI

struct FormFieldContainer<Content: View, Form: FormFieldRepresentable>: View {

    // MARK: - Bindings

    @Binding private var field: Form

    // MARK: - Public Properties

    private let content: Content
    private let accessibilityLabel: LocalizedStringKey

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            content

            if !messages.isEmpty {
                VStack(alignment: .leading) {
                    ForEach(Array(messages.enumerated()), id: \.offset) { _, message in
                        Text(message)
                    }
                }
                .font(.callout)
                .foregroundStyle(.red)
                .accessibilityElement(children: .combine)
                .accessibilityLabel(Text(accessibilityLabel))
                .accessibilityValue(Text(verbatim: messages.joined(separator: ", ")))
            }
        }
        .disabled(field.isDisabled)
        .isHidden(field.isHidden)
    }

    // MARK: - Private Properties

    private var messages: [String] {
        (field.showErrors ? field.errors : []).map { $0.localizedDescription }
    }

    // MARK: - Initializer

    init(
        _ field: Binding<Form>,
        accessibilityLabel: String,
        @ViewBuilder _ content: () -> Content
    ) {
        self._field = field

        self.content = content()
        self.accessibilityLabel = LocalizedStringKey(accessibilityLabel)
    }

}
