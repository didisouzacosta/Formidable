//
//  ReferenceValue.swift
//  Formidable
//
//  Created by Adriano Costa on 27/01/25.
//

public enum ReferenceValue<Value, Root> {
    case staticValue(Value)
    case keyPath(KeyPath<Root, Value>)
}
