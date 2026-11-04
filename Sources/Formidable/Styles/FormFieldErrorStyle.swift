//
//  FormFieldErrorStyle.swift
//  Formidable
//
//  Created by Adriano Costa on 04/11/26.
//

import SwiftUI

/// A type that defines how the validation messages of a Formidable field are presented.
///
/// Apply a style to a single field or to an entire hierarchy with
/// ``SwiftUI/View/formFieldErrorStyle(_:)``. Fields without a custom style use
/// ``DefaultFormFieldErrorStyle``.
///
/// The field container keeps ownership of accessibility: the view returned by
/// ``makeBody(configuration:)`` is combined into a single accessibility element that uses
/// the field's accessibility label and the joined messages as its value.
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
/// struct SignInView: View {
///     @State private var form = SignInForm()
///
///     var body: some View {
///         @Bindable var form = form
///
///         Form {
///             TextField("Email", text: $form.email.value)
///                 .field($form.email, accessibilityLabel: "Email errors")
///         }
///         .formFieldErrorStyle(CompactErrorStyle())
///     }
/// }
/// ```
public protocol FormFieldErrorStyle: Sendable {

    // MARK: - Public Properties

    /// The view produced by the style.
    associatedtype Body: View

    /// The properties of the error presentation being styled.
    typealias Configuration = FormFieldErrorStyleConfiguration

    // MARK: - Public Methods

    /// Creates the view that presents the field's visible validation messages.
    ///
    /// The method is only called when there is at least one visible error.
    ///
    /// - Parameter configuration: The visible errors and their localized messages.
    @MainActor @ViewBuilder func makeBody(configuration: Configuration) -> Body

}
