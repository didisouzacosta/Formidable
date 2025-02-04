import Testing

@testable import Formidable

struct GreaterThanOrEqualRuleTests {
 
    private let error = TestError.validationError
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = GreaterThanOrEqualRule(20, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsGreaterThanOrEqual() throws {
        let rule = GreaterThanOrEqualRule(20, error: error)
        
        try rule.validate(21)
        try rule.validate(20)
    }
    
    @Test func mustBeInvalidWhenValueIsNotGreaterThanOrEqual() {
        let rule = GreaterThanOrEqualRule(10, error: error)

        #expect(throws: error) {
            try rule.validate(9)
        }
    }
    
}

fileprivate struct Person {
    
    let age: Int
    
    init(_ age: Int) {
        self.age = age
    }
    
}
