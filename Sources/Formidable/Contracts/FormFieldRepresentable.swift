//
//  FormFieldRepresentable.swift
//  Formidable
//
//  Created by Adriano Costa on 24/01/25.
//

import SwiftUI

public protocol FormFieldRepresentable: ObservableObject {
    
    associatedtype Value: Equatable
    
    var value: Value { get set }
    var originalValue: Value { get }
    var isModified: Bool { get }
    var isHidden: Bool { get set }
    var isDisabled: Bool { get set }
    var showErrors: Bool { get set }
    var rules: [any FormFieldRule] { get set }
    
    var transform: ((Value) -> Value)? { get set }
    var valueChange: ((Value, Value) -> Void)? { get set }
    
}

public extension FormFieldRepresentable {
    
    /// A computed property that indicates if the field contains any error
    /// Returns `true` if value not contains any errors, `false` otherwise.
    var isValid: Bool {
        errors.isEmpty
    }
    
    /// A computed property that indicates if the value is modified
    /// Returns `true` if value is modified, `false` otherwise.
    var isModified: Bool {
        originalValue != value
    }
    
    /// A computed property that gathers all errors from the form field.
    /// Returns an array of errors.
    var errors: [Error] {
        if isDisabled || isHidden {
            []
        } else {
            rules.compactMap { rule in
                do {
                    try AnyRule(rule).validate(value)
                    return nil
                } catch {
                    return error
                }
            }
        }
    }
    
    /// Resets field in the form to initial value, clearing any errors.
    func reset() {
        value = originalValue
        showErrors = false
    }
    
}
