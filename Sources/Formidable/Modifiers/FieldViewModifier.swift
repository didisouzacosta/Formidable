//
//  FieldViewModifier.swift
//  Formidable
//
//  Created by Adriano Costa on 23/01/25.
//

import SwiftUI

extension View {

    // MARK: - Public Methods

    /// Attaches Formidable state, validation messages, and accessibility metadata to a SwiftUI control.
    ///
    /// # Example
    ///
    /// ```swift
    /// @Observable
    /// final class SignInForm: Formidable {
    ///     var email = FormField("")
    /// }
    ///
    /// struct SignInView: View {
    ///     @State private var form = SignInForm()
    ///
    ///     var body: some View {
    ///         @Bindable var form = form
    ///
    ///         TextField("Email", text: $form.email.value)
    ///             .field($form.email, accessibilityLabel: "Email errors")
    ///     }
    /// }
    /// ```
    public func field<Value: Equatable>(
        _ field: Binding<FormField<Value>>,
        accessibilityLabel: String = "Field errors"
    ) -> some View {
        modifier(
            FieldViewModifier(
                field,
                accessibilityLabel: accessibilityLabel
            )
        )
    }

}

/// A view modifier that applies Formidable visibility, disabled state, and validation-message presentation.
///
/// Prefer the ``SwiftUI/View/field(_:accessibilityLabel:)`` convenience method at call sites.
///
/// # Example
///
/// ```swift
/// TextField("Name", text: $form.name.value)
///     .modifier(FieldViewModifier($form.name, accessibilityLabel: "Name errors"))
/// ```
public struct FieldViewModifier<Value: Equatable>: ViewModifier {

    // MARK: - Public Properties

    private let field: Binding<FormField<Value>>
    private let accessibilityLabel: String

    // MARK: - Initializer

    /// Creates a modifier for a field binding and a localizable accessibility label.
    public init(
        _ field: Binding<FormField<Value>>,
        accessibilityLabel: String
    ) {
        self.field = field
        self.accessibilityLabel = accessibilityLabel
    }

    // MARK: - Public Methods

    /// Wraps the modified content in a Formidable field container.
    public func body(content: Content) -> some View {
        FormFieldContainer(
            field,
            accessibilityLabel: accessibilityLabel
        ) {
            content
        }
    }

}
