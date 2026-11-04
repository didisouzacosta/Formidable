//
//  FormFieldErrorStyleConfiguration.swift
//  Formidable
//
//  Created by Adriano Costa on 04/11/26.
//

/// The properties of a field's error presentation passed to a ``FormFieldErrorStyle``.
///
/// Formidable creates the configuration from the errors that are currently visible, that is,
/// the field's errors once `showErrors` is enabled.
///
/// # Example
///
/// ```swift
/// struct BulletedErrorStyle: FormFieldErrorStyle {
///     func makeBody(configuration: Configuration) -> some View {
///         ForEach(Array(configuration.messages.enumerated()), id: \.offset) { _, message in
///             Label(message, systemImage: "exclamationmark.circle")
///         }
///         .font(.footnote)
///         .foregroundStyle(.red)
///     }
/// }
/// ```
public struct FormFieldErrorStyleConfiguration: Sendable {

    // MARK: - Public Properties

    /// The visible validation errors, in the order the field's rules produced them.
    public let errors: [any Error]

    /// The localized descriptions of ``errors``, in the same order.
    public var messages: [String] {
        errors.map { $0.localizedDescription }
    }

    // MARK: - Initializer

    init(errors: [any Error]) {
        self.errors = errors
    }

}
