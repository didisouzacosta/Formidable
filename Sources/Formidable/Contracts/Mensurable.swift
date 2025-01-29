//
//  Mensurable.swift
//  Formidable
//
//  Created by Adriano Costa on 29/01/25.
//

import Foundation

public protocol Mensurable {
    
    var lenght: Double { get }
    
}

extension Array: Mensurable {
    
    public var lenght: Double {
        Double(count)
    }
    
}

extension Int: Mensurable {
    
    public var lenght: Double {
        Double(self)
    }
    
}

extension Double: Mensurable {
    
    public var lenght: Double {
        self
    }
    
}

extension Float: Mensurable {
    
    public var lenght: Double {
        Double(self)
    }
    
}

extension Data: Mensurable {
    
    public var lenght: Double {
        Double(count)
    }
    
}

extension String: Mensurable {
    
    public var lenght: Double {
        Double(count)
    }
    
}
