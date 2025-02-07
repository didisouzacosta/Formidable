//
//  EmptableTests.swift
//  Formidable
//
//  Created by Adriano Costa on 07/02/25.
//

import Testing
import Foundation

@testable import Formidable

struct EmptableTests {
    
    @Test func ensureThatValuesAreEmpty() throws {
        #expect("".isEmpty)
        #expect(false.isEmpty)
        #expect([].isEmpty)
        #expect(Data().isEmpty)
        #expect(0.isEmpty)
        #expect(Double(0).isEmpty)
        #expect(Float(0).isEmpty)
    }
    
    @Test func ensureThatValuesAreNotEmpty() throws {
        #expect("Formidable".isEmpty == false)
        #expect(true.isEmpty == false)
        #expect(["Orlando", "Gisele", "Adriano"].isEmpty == false)
        #expect("123".data(using: .utf8)?.isEmpty == false)
        #expect(1.isEmpty == false)
        #expect(Double(1.0).isEmpty == false)
        #expect(Float(1.0).isEmpty == false)
    }
    
}
