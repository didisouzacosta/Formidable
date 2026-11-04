//
//  FormFieldContainer.swift
//  Formidable
//
//  Created by Adriano Costa on 15/01/25.
//

import SwiftUI

struct FormFieldContainer<Content: View, Form: FormFieldRepresentable>: View {

    // MARK: - Environments

    @Environment(\.formFieldErrorStyle) private var errorStyle

    // MARK: - Bindings

    @Binding private var field: Form

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            content

            if !configuration.errors.isEmpty {
                makeErrorView(errorStyle, configuration: configuration)
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel(Text(accessibilityLabel))
                    .accessibilityValue(Text(verbatim: configuration.messages.joined(separator: ", ")))
            }
        }
        .disabled(field.isDisabled)
        .isHidden(field.isHidden)
    }

    // MARK: - Private Properties

    private let content: Content
    private let accessibilityLabel: LocalizedStringKey

    private var configuration: FormFieldErrorStyleConfiguration {
        FormFieldErrorStyleConfiguration(errors: field.showErrors ? field.errors : [])
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

    // MARK: - Private Methods

    private func makeErrorView(
        _ style: some FormFieldErrorStyle,
        configuration: FormFieldErrorStyleConfiguration
    ) -> AnyView {
        AnyView(style.makeBody(configuration: configuration))
    }

}
