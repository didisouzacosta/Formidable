//
//  DefaultFormFieldErrorStyle.swift
//  Formidable
//
//  Created by Adriano Costa on 04/11/26.
//

import SwiftUI

/// The default error style, which lists each message in red using the callout font.
///
/// Use ``FormFieldErrorStyle/automatic`` to restore the default inside a hierarchy that
/// applies a custom style.
///
/// # Example
///
/// ```swift
/// Form {
///     TextField("Name", text: $form.name.value)
///         .field($form.name, accessibilityLabel: "Name errors")
///         .formFieldErrorStyle(.automatic)
/// }
/// .formFieldErrorStyle(CompactErrorStyle())
/// ```
public struct DefaultFormFieldErrorStyle: FormFieldErrorStyle {

    // MARK: - Initializer

    /// Creates the default error style.
    public init() {}

    // MARK: - Public Methods

    /// Lists the messages vertically in red using the callout font.
    public func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            ForEach(Array(configuration.messages.enumerated()), id: \.offset) { _, message in
                Text(message)
            }
        }
        .font(.callout)
        .foregroundStyle(.red)
    }

}

extension FormFieldErrorStyle where Self == DefaultFormFieldErrorStyle {

    // MARK: - Public Properties

    /// The default error style.
    public static var automatic: DefaultFormFieldErrorStyle {
        DefaultFormFieldErrorStyle()
    }

}
