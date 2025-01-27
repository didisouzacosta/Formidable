//
//  FormFieldRule.swift
//  Formidable
//
//  Created by Adriano Costa on 13/01/25.
//

public protocol FormFieldRule {
    
    associatedtype Value
    
    func validate(_ value: Value?) throws
    
}


