//
//  FieldViewModifier.swift
//  Formidable
//
//  Created by Adriano Costa on 23/01/25.
//

import SwiftUI

public extension View {
    
    func field<Value: Equatable>(_ field: Binding<FormField<Value>>) -> some View {
        modifier(FieldViewModifier(field))
    }
    
}

public struct FieldViewModifier<Value: Equatable>: ViewModifier {
    
    private let field: Binding<FormField<Value>>
    
    public init(_ field: Binding<FormField<Value>>) {
        self.field = field
    }
    
    public func body(content: Content) -> some View {
        FormFieldContainer(field) {
            content
        }
    }
    
}
