//
//  FieldViewModifier.swift
//  Formidable
//
//  Created by Adriano Costa on 23/01/25.
//

import SwiftUI

public extension View {
    
    func field<Value: Equatable>(_ field: Binding<FormFieldValue<Value>>) -> some View {
        modifier(FieldViewModifier(field))
    }
    
}

public struct FieldViewModifier<Value: Equatable>: ViewModifier {
    
    private let field: Binding<FormFieldValue<Value>>
    
    public init(_ field: Binding<FormFieldValue<Value>>) {
        self.field = field
    }
    
    public func body(content: Content) -> some View {
        FormFieldContainer(field) {
            content
        }
    }
    
}
