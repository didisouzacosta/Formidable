import Testing

@testable import Formidable

struct ContainsRuleTests {
 
    private let error = TestError.validationError
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = ContainsRule(in: [10, 11, 12], error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenTheCollectionContainsTheValue() throws {
        let rule = ContainsRule(in: [10, 11, 12], error: error)
        
        try rule.validate(10)
    }
    
    @Test func mustBeInvalidWhenTheCollectionNotContainsTheValue() throws {
        let rule = ContainsRule(in: [10, 11, 12], error: error)
        
        #expect(throws: error) {
            try rule.validate(9)
        }
    }
    
}
