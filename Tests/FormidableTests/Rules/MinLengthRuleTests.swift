import Testing

@testable import Formidable

struct MinLengthRuleTests {
 
    private let error = TestError.validationError
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = MinLengthRule(10, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsGraterThanOrEqualReferenceValue() throws {
        let rule = MinLengthRule(10, error: error)
        
        try rule.validate(11)
        try rule.validate(10)
    }
    
    @Test func mustBeInvalidWhenValueIsLessThanReferenceValue() throws {
        let rule = MinLengthRule(10, error: error)
        
        #expect(throws: error) {
            try rule.validate(9)
        }
    }
    
}
