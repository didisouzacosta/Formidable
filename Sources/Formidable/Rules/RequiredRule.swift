//
//  RequiredRule.swift
//  Formidable
//
//  Created by Adriano Costa on 14/01/25.
//

import SwiftUI

/// A validation rule that ensures a value is not empty.
///
/// The `RequiredRule` is designed to validate that a given value conforms to the `Emptable` protocol,
/// which defines an `isEmpty` property. If the value is `nil` or considered empty, the rule throws
/// the provided error.
///
/// - Generic Parameters:
///   - `T`: A type that conforms to the `Emptable` protocol.
///
/// ## Protocol Requirements
/// The `Emptable` protocol must be adopted by any type used with this rule. It defines the following:
/// ```swift
/// public protocol Emptable {
///     var isEmpty: Bool { get }
/// }
/// ```
///
/// ## Example Usage
///
/// ### Using `String` as an `Emptable`
/// The `String` type can conform to the `Emptable` protocol as follows:
/// ```swift
/// extension String: Emptable {
///     public var isEmpty: Bool { self.isEmpty }
/// }
/// ```
///
/// ### Validation Example
/// ```swift
/// enum ValidationError: Error {
///     case fieldRequired
/// }
///
/// // Create a required rule with a specific error
/// let requiredRule = RequiredRule(ValidationError.fieldRequired)
///
/// do {
///     try requiredRule.validate("Hello") // Passes
///     try requiredRule.validate("") // Throws ValidationError.fieldRequired
///     try requiredRule.validate(nil) // Throws ValidationError.fieldRequired
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
///
/// ### Using a Custom Type
/// If you have a custom type, you can conform it to `Emptable` and use the `RequiredRule`:
/// ```swift
/// struct CustomValue: Emptable {
///     let items: [Int]
///
///     var isEmpty: Bool {
///         items.isEmpty
///     }
/// }
///
/// let customValue = CustomValue(items: [])
/// let requiredRule = RequiredRule(ValidationError.fieldRequired)
///
/// do {
///     try requiredRule.validate(customValue) // Throws ValidationError.fieldRequired
/// } catch {
///     print("Validation failed: \(error)")
/// }
/// ```
public struct RequiredRule: FormFieldRule {
    
    public typealias T = Emptable
    
    // MARK: - Private Variables
    
    /// The error to throw when validation fails.
    private let error: Error
    
    // MARK: - Initializers
    
    /// Creates a new `RequiredRule` with the specified error.
    ///
    /// - Parameter error: The error to throw if the validation fails.
    public init(_ error: Error) {
        self.error = error
    }
    
    // MARK: - Public Methods
    
    /// Validates that the given value is not empty.
    ///
    /// - Parameter value: The value to validate.
    /// - Throws: The specified error if the value is `nil` or empty.
    public func validate(_ value: T?) throws {
        guard let value else {
            throw error
        }
        
        guard !value.isEmpty else {
            throw error
        }
    }
    
}

public protocol Emptable {
    var isEmpty: Bool { get }
}

extension String: Emptable {}
extension Data: Emptable {}
extension Array: Emptable {}

extension Int: Emptable {
    
    public var isEmpty: Bool {
        false
    }
    
}

extension Double: Emptable {
    
    public var isEmpty: Bool {
        false
    }
    
}

extension Float: Emptable {
    
    public var isEmpty: Bool {
        false
    }
    
}

extension Date: Emptable {
    
    public var isEmpty: Bool {
        false
    }
    
}


