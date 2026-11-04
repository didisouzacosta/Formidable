//
//  FormFieldErrorStyleEnvironmentTests.swift
//  Formidable
//
//  Created by Adriano Costa on 04/11/26.
//

import Testing
import SwiftUI

@testable import Formidable

@MainActor
struct FormFieldErrorStyleEnvironmentTests {

    @Test func defaultStyleIsAutomatic() {
        let environment = EnvironmentValues()

        #expect(environment.formFieldErrorStyle is DefaultFormFieldErrorStyle)
    }

    @Test func customStyleIsStoredInTheEnvironment() {
        var environment = EnvironmentValues()

        environment.formFieldErrorStyle = CompactErrorStyle()

        #expect(environment.formFieldErrorStyle is CompactErrorStyle)
    }

}

private struct CompactErrorStyle: FormFieldErrorStyle {

    // MARK: - Public Methods

    func makeBody(configuration: Configuration) -> some View {
        Text(configuration.messages.joined(separator: "\n"))
            .font(.caption)
    }

}
