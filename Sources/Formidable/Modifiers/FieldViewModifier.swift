//
//  FieldViewModifier.swift
//  Formidable
//
//  Created by Adriano Costa on 23/01/25.
//

import SwiftUI

public extension View {
    
    func field<Value: Equatable>(
        _ field: Binding<FormField<Value>>,
        accessibilityLabel: String = "Field errors"
    ) -> some View {
        modifier(FieldViewModifier(field, accessibilityLabel: accessibilityLabel))
    }
    
}

public struct FieldViewModifier<Value: Equatable>: ViewModifier {
    
    private let field: Binding<FormField<Value>>
    private let accessibilityLabel: String
    
    public init(
        _ field: Binding<FormField<Value>>,
        accessibilityLabel: String
    ) {
        self.field = field
        self.accessibilityLabel = accessibilityLabel
    }
    
    public func body(content: Content) -> some View {
        FormFieldContainer(field) {
            content
        }
    }
    
}
