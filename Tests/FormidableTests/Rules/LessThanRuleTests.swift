import Testing

@testable import Formidable

struct LessThanRuleTests {
 
    private let error = TestError.validationError
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = LessThanRule(20, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsLess() throws {
        let rule = LessThanRule(20, error: error)
        
        try rule.validate(19)
    }
    
    @Test func mustBeInvalidWhenValueIsNotLess() {
        let rule = LessThanRule(10, error: error)

        #expect(throws: error) {
            try rule.validate(11)
        }
    }
    
}
