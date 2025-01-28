//
//  TestError.swift
//  Formidable
//
//  Created by Adriano Costa on 28/01/25.
//

enum TestError: Error, Equatable {
    case valuesAreNotEqual
    case valueAreNotGreater
    case valueAreNotLess
    case valueAreNotLessThanOrEqual
    case valueAreNotGreaterThanOrEqual
}

