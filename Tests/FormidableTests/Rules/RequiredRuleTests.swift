import Testing
import SwiftUI

@testable import Formidable

struct RequiredRuleTests {
 
    private let error = TestError.validationError
    
    @Test func mustBeValidWhenValidateValueIsNotNil() throws {
        let rule = RequiredRule(error)
        
        try rule.validate("100")
        try rule.validate([1])
        try rule.validate(["Adriano"])
        try rule.validate(Date.now)
        try rule.validate(36)
        try rule.validate(36.9)
        try rule.validate(Float(2.2))
        try rule.validate(-100)
    }
    
    @Test func mustBeNotValidWhenValidateValueIsZero() throws {
        let rule = RequiredRule(error)
        
        #expect(throws: error) {
            try rule.validate(0)
            try rule.validate(Double(0.0))
            try rule.validate(Float(0.0))
        }
    }
    
    @Test func mustBeNotValidWhenValidateValueIsNil() throws {
        let rule = RequiredRule(error)
        
        #expect(throws: error) {
            try rule.validate(nil)
        }
    }
    
    @Test func mustBeNotValidWhenValidateValueIsAnEmptyArray() throws {
        let rule = RequiredRule(error)
        
        #expect(throws: error) {
            try rule.validate([])
        }
    }
    
    @Test func mustBeNotValidWhenValidateValueIsAnEmptyData() throws {
        let rule = RequiredRule(error)
        
        #expect(throws: error) {
            try rule.validate(Data())
        }
    }
    
}
