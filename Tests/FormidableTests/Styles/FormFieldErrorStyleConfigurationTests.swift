//
//  FormFieldErrorStyleConfigurationTests.swift
//  Formidable
//
//  Created by Adriano Costa on 04/11/26.
//

import Testing
import Foundation

@testable import Formidable

@MainActor
struct FormFieldErrorStyleConfigurationTests {

    @Test func messagesFollowTheErrorOrder() {
        let first = NSError(domain: "Formidable", code: 1, userInfo: [NSLocalizedDescriptionKey: "First"])
        let second = NSError(domain: "Formidable", code: 2, userInfo: [NSLocalizedDescriptionKey: "Second"])

        let configuration = FormFieldErrorStyleConfiguration(errors: [first, second])

        #expect(configuration.messages == ["First", "Second"])
    }

    @Test func emptyErrorsProduceNoMessages() {
        let configuration = FormFieldErrorStyleConfiguration(errors: [])

        #expect(configuration.errors.isEmpty)
        #expect(configuration.messages.isEmpty)
    }

    @Test func errorsKeepTheirOriginalValues() {
        let configuration = FormFieldErrorStyleConfiguration(errors: [TestError.validationError])

        #expect(configuration.errors.first as? TestError == .validationError)
    }

}
