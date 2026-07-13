//
//  Mensurable.swift
//  Formidable
//
//  Created by Adriano Costa on 31/01/25.
//

import Foundation

/// A value that exposes a numeric measure for length validation.
///
/// Collection and text conformances use element count, numeric values use their own magnitude, and `Date`
/// uses seconds since the reference epoch used by `timeIntervalSince1970`.
///
/// # Example
///
/// ```swift
/// let text: any Mensurable = "Swift"
/// print(text.length) // 5.0
/// ```
public protocol Mensurable {

    /// The numeric measure used by minimum- and maximum-length rules.
    var length: Double { get }

}

extension Array: Mensurable {

    // MARK: - Public Properties

    /// The number of elements in the array.
    public var length: Double {
        Double(count)
    }

}

extension Int: Mensurable {

    // MARK: - Public Properties

    /// The integer represented as a `Double`.
    public var length: Double {
        Double(self)
    }

}

extension Double: Mensurable {

    // MARK: - Public Properties

    /// The value itself.
    public var length: Double {
        self
    }

}

extension Float: Mensurable {

    // MARK: - Public Properties

    /// The value represented as a `Double`.
    public var length: Double {
        Double(self)
    }

}

extension Date: Mensurable {

    // MARK: - Public Properties

    /// The number of seconds since 1 January 1970.
    public var length: Double {
        Double(timeIntervalSince1970)
    }

}

extension Data: Mensurable {

    // MARK: - Public Properties

    /// The number of bytes in the data.
    public var length: Double {
        Double(count)
    }

}

extension String: Mensurable {

    // MARK: - Public Properties

    /// The number of extended grapheme clusters in the string.
    public var length: Double {
        Double(count)
    }

}
