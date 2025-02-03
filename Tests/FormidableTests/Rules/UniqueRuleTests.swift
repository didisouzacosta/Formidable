import Testing

@testable import Formidable

struct UniqueRuleTests {
 
    private let error = TestError.alreadyExists
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = UniqueRule(in: [10], error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueNotExistsYet() throws {
        let rule = UniqueRule(in: [10], error: error)
        
        try rule.validate(11)
    }
    
    @Test func mustBeInvalidWhenValueAlreadyExists() throws {
        let rule = UniqueRule(in: [10, 11, 12], error: error)
        
        #expect(throws: error) {
            try rule.validate(11)
        }
    }
    
}
