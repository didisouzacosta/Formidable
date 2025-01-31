//
//  Mensurable.swift
//  Formidable
//
//  Created by Adriano Costa on 31/01/25.
//

import Foundation

public protocol Mensurable {
    
    var length: Double { get }
    
}

extension Array: Mensurable {
    
    public var length: Double {
        Double(count)
    }
    
}

extension Int: Mensurable {
    
    public var length: Double {
        Double(self)
    }
    
}

extension Double: Mensurable {
    
    public var length: Double {
        self
    }
    
}

extension Float: Mensurable {
    
    public var length: Double {
        Double(self)
    }
    
}

extension Date: Mensurable {
    
    public var length: Double {
        Double(timeIntervalSince1970)
    }
    
}

extension Data: Mensurable {
    
    public var length: Double {
        Double(count)
    }
    
}

extension String: Mensurable {
    
    public var length: Double {
        Double(count)
    }
    
}
