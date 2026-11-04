//
//  FormFieldErrorStyleViewModifier.swift
//  Formidable
//
//  Created by Adriano Costa on 04/11/26.
//

import SwiftUI

extension EnvironmentValues {

    // MARK: - Public Properties

    @Entry var formFieldErrorStyle: any FormFieldErrorStyle = DefaultFormFieldErrorStyle()

}

extension View {

    // MARK: - Public Methods

    /// Sets the style used to present validation messages of Formidable fields in this view hierarchy.
    ///
    /// The style applies to every `.field(_:accessibilityLabel:)` inside the modified view,
    /// so it can be set once on a `Form` or on a single field.
    ///
    /// # Example
    ///
    /// ```swift
    /// struct CompactErrorStyle: FormFieldErrorStyle {
    ///     func makeBody(configuration: Configuration) -> some View {
    ///         VStack(alignment: .leading, spacing: 2) {
    ///             ForEach(Array(configuration.messages.enumerated()), id: \.offset) { _, message in
    ///                 Text(message)
    ///             }
    ///         }
    ///         .font(.caption)
    ///         .foregroundStyle(.red)
    ///     }
    /// }
    ///
    /// Form {
    ///     TextField("Email", text: $form.email.value)
    ///         .field($form.email, accessibilityLabel: "Email errors")
    /// }
    /// .formFieldErrorStyle(CompactErrorStyle())
    /// ```
    ///
    /// - Parameter style: The style to apply.
    public func formFieldErrorStyle(_ style: some FormFieldErrorStyle) -> some View {
        modifier(FormFieldErrorStyleViewModifier(style))
    }

}

struct FormFieldErrorStyleViewModifier: ViewModifier {

    // MARK: - Private Properties

    private let style: any FormFieldErrorStyle

    // MARK: - Initializer

    init(_ style: some FormFieldErrorStyle) {
        self.style = style
    }

    // MARK: - Public Methods

    func body(content: Content) -> some View {
        content.environment(\.formFieldErrorStyle, style)
    }

}
