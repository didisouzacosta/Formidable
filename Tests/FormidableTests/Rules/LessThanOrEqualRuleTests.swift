import Testing

@testable import Formidable

struct LessThanOrEqualRuleTests {
 
    private let error = TestError.areNotLessThanOrEqual
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = LessThanOrEqualRule(20, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsLessThanOrEqual() throws {
        let rule = LessThanOrEqualRule(20, error: error)
        
        try rule.validate(20)
        try rule.validate(19)
    }
    
    @Test func mustBeInvalidWhenValueIsNotLessThanOrEqual() {
        let rule = LessThanOrEqualRule(10, error: error)

        #expect(throws: error) {
            try rule.validate(11)
        }
    }
    
}

fileprivate struct Person {
    
    let age: Int
    
    init(_ age: Int) {
        self.age = age
    }
    
}
