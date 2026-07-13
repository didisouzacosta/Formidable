//
//  FormFieldTests.swift
//  Formidable
//
//  Created by Adriano Costa on 28/01/25.
//

import Testing
import SwiftUI

@testable import Formidable

@MainActor
struct FormFieldTests {
    
    @Test func ensureDefaultProperties() throws {
        let field = FormField(44)
        
        #expect(field.value == 44)
        #expect(field.originalValue == 44)
        #expect(field.isModified == false)
        #expect(field.isHidden == false)
        #expect(field.isDisabled == false)
        #expect(field.transform == nil)
        #expect(field.isValid == true)
        #expect(field.showErrors == false)
        #expect(field.errors.count == 0)
    }
    
    @Test func originalValueMustBeNotChangeAfterSetNewValue() throws {
        let field = FormField(44)
        
        #expect(field.value == 44)
        #expect(field.originalValue == 44)
        
        field.value = 23
        
        #expect(field.value == 23)
        #expect(field.originalValue == 44)
    }
    
    @Test func isModifiedMustBeTrueAfterSetNewValue() throws {
        let field = FormField(44)
        
        #expect(field.isModified == false)
        
        field.value = 23
        
        #expect(field.isModified == true)
        
        field.value = 44
        
        #expect(field.isModified == false)
    }
    
    
    @Test func isValidMustBeChangeAfterSetInvalidValue() throws {
        let field = FormField("Orlando")
        field.rules = [RequiredRule(TestError.validationError)]
        
        #expect(field.isValid == true)
        
        field.value = ""
        
        #expect(field.isValid == false)
        #expect(field.errors.count == 1)
        #expect(field.errors.first?.localizedDescription == TestError.validationError.localizedDescription)
        
        field.rules = []
        
        #expect(field.isValid == true)
        #expect(field.errors.isEmpty)
    }
    
    @Test func disabledFieldsMustAlwaysBeValid() throws {
        let field = FormField("Orlando")
        field.rules = [RequiredRule(TestError.validationError)]
        field.isDisabled = true
        
        #expect(field.isValid == true)
    }
    
    @Test func hiddenFieldsMustAlwaysBeValid() throws {
        let field = FormField("Orlando")
        field.rules = [RequiredRule(TestError.validationError)]
        field.isHidden = true
        
        #expect(field.isValid == true)
    }
    
    @Test func ensureValueTransformConsistency() {
        let field = FormField(36)
        field.transform = { $0 + 4 }
        
        #expect(field.originalValue == 36)
        #expect(field.value == 40)
        #expect(field.isModified == true)
    }
    
    @Test func ensureValueTransformOnInit() {
        let field = FormField(36, transform: { $0 + 4 })
        
        #expect(field.originalValue == 40)
        #expect(field.value == 40)
        #expect(field.isModified == false)
    }
    
    @Test func ensureExternalBindingSynchronization() throws {
        var externalValue = "Initial"
        let binding = Binding(get: { externalValue }, set: { externalValue = $0 })
        let field = FormField(binding)
        
        #expect(field.value == "Initial")
        
        field.value = "Updated"
        
        #expect(externalValue == "Updated")
        #expect(field.value == "Updated")
    }

    @Test func assigningValueEnablesErrorsAndResetClearsThem() {
        let field = FormField("Initial")

        field.value = "Updated"

        #expect(field.showErrors)

        field.reset()

        #expect(field.showErrors == false)
    }

    @Test func directExternalChangeDoesNotEnableErrors() {
        var externalValue = "Initial"
        let binding = Binding(get: { externalValue }, set: { externalValue = $0 })
        let field = FormField(binding)

        externalValue = "External update"

        #expect(field.value == "External update")
        #expect(field.showErrors == false)
    }

    @Test func resetRestoresExternalBinding() {
        var externalValue = "Initial"
        let binding = Binding(get: { externalValue }, set: { externalValue = $0 })
        let field = FormField(binding)

        field.value = "Updated"
        field.reset()

        #expect(externalValue == "Initial")
        #expect(field.value == "Initial")
        #expect(field.showErrors == false)
    }

    @Test func resetDoesNotApplyNonIdempotentTransformTwice() {
        let field = FormField("Initial", transform: { $0 + "!" })

        #expect(field.originalValue == "Initial!")

        field.value = "Updated"
        #expect(field.value == "Updated!")
        #expect(field.isModified)

        field.reset()

        #expect(field.value == "Initial!")
        #expect(field.originalValue == "Initial!")
        #expect(field.isModified == false)
    }

    @Test func resetPreservesOriginalValueAndModificationState() {
        let field = FormField(10, transform: { $0 * 2 })

        field.value = 15

        #expect(field.originalValue == 20)
        #expect(field.isModified)

        field.reset()

        #expect(field.originalValue == 20)
        #expect(field.value == 20)
        #expect(field.isModified == false)
    }
    
}
