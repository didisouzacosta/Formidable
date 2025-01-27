// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@MainActor
public protocol Formidable: ObservableObject {}

public extension Formidable {
    
    func validate() throws {
        fields.forEach { $0.showErrors = true }
        if let error = errors.first {
            throw error
        }
    }
    
    func reset() {
        fields.forEach { $0.reset() }
    }
    
    var isValid: Bool {
        errors.isEmpty
    }
    
    var errors: [Error] {
        fields.flatMap { $0.errors.flatMap { $0 } }
    }
    
    // MARK: Private Properties
    
    var fields: [any FormField] {
        Mirror(reflecting: self).children.compactMap { $0.value as? any FormField }
    }
    
}
