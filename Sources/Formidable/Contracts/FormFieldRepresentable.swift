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
    
    var isValid: Bool {
        errors.isEmpty
    }
    
    var isModified: Bool {
        originalValue != value
    }
    
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
    
    func reset() {
        value = originalValue
        showErrors = false
    }
    
}
