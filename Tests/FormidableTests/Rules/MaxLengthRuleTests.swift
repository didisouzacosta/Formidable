import Testing

@testable import Formidable

struct MaxLengthRuleTests {
 
    private let error = TestError.validationError
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = MaxLengthRule(10, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsLessThanOrEqualReferenceValue() throws {
        let rule = MaxLengthRule("Orlando", error: error)
        
        try rule.validate(7)
        try rule.validate(6)
    }
    
    @Test func mustBeInvalidWhenValueIsGreaterThanReferenceValue() throws {
        let rule = MaxLengthRule(10, error: error)
        
        #expect(throws: error) {
            try rule.validate(11)
        }
    }
    
}

fileprivate struct Game {
    
    let rating: Int
    
    init(_ rating: Int) {
        self.rating = rating
    }
    
}
