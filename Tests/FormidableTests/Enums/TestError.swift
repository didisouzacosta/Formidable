//
//  TestError.swift
//  Formidable
//
//  Created by Adriano Costa on 28/01/25.
//

enum TestError: Error, Equatable {
    case isRequired
    case areNotEqual
    case areNotGreater
    case areNotLess
    case areNotLessThanOrEqual
    case areNotGreaterThanOrEqual
    case alreadyExists
    case minLength
    case maxLength
}

