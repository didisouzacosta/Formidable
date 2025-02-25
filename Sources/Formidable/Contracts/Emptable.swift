//
//  Emptable.swift
//  Formidable
//
//  Created by Adriano Costa on 29/01/25.
//

import Foundation

public protocol Emptable {
    var isEmpty: Bool { get }
}

extension String: Emptable {}
extension Data: Emptable {}
extension Array: Emptable {}

extension Bool: Emptable {
    
    public var isEmpty: Bool {
        self == false
    }
    
}

extension Int: Emptable {
    
    public var isEmpty: Bool {
        self == 0
    }
    
}

extension Double: Emptable {
    
    public var isEmpty: Bool {
        self == 0
    }
    
}

extension Float: Emptable {
    
    public var isEmpty: Bool {
        self == 0
    }
    
}

extension Date: Emptable {
    
    public var isEmpty: Bool {
        false
    }
    
}
