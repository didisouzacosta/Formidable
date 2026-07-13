//
//  Emptable.swift
//  Formidable
//
//  Created by Adriano Costa on 29/01/25.
//

import Foundation

/// A value that can report whether it represents an empty form input.
///
/// # Example
///
/// ```swift
/// let text: any Emptable = ""
/// print(text.isEmpty) // true
/// ```
public protocol Emptable {

    /// Indicates whether the value represents an empty input.
    var isEmpty: Bool { get }

}

extension String: Emptable {

}

extension Data: Emptable {

}

extension Array: Emptable {

}

extension Bool: Emptable {

    // MARK: - Public Properties

    /// Indicates whether the Boolean value is `false`.
    public var isEmpty: Bool {
        self == false
    }

}

extension Int: Emptable {

    // MARK: - Public Properties

    /// Indicates whether the integer is zero.
    public var isEmpty: Bool {
        self == 0
    }

}

extension Double: Emptable {

    // MARK: - Public Properties

    /// Indicates whether the floating-point value is zero.
    public var isEmpty: Bool {
        self == 0
    }

}

extension Float: Emptable {

    // MARK: - Public Properties

    /// Indicates whether the floating-point value is zero.
    public var isEmpty: Bool {
        self == 0
    }

}

extension Date: Emptable {

    // MARK: - Public Properties

    /// Always returns `false` because every `Date` represents a value.
    public var isEmpty: Bool {
        false
    }

}
