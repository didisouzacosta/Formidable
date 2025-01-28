import Testing

@testable import Formidable

struct RequiredRuleTests {
 
    private let error = TestError.valueIsRequired
    
    @Test func mustBeValidWhenValidateValueIsNotNil() throws {
        let rule = RequiredRule(error)
        try rule.validate("100")
    }
    
    @Test func mustBeNotValidWhenValidateValueIsNil() throws {
        let rule = RequiredRule(error)
        
        #expect(throws: error) {
            try rule.validate(nil)
        }
    }
    
}
