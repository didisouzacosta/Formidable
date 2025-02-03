import Testing

@testable import Formidable

struct EqualRuleTests {
 
    private let error = TestError.areNotEqual
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = EqualRule(10, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsEqual() throws {
        let rule = EqualRule(10, error: error)
        
        try rule.validate(10)
    }
    
    @Test func mustBeInvalidWhenValueIsNotEqual() {
        let rule = EqualRule(10, error: error)

        #expect(throws: error) {
            try rule.validate(5)
        }
    }
    
}
