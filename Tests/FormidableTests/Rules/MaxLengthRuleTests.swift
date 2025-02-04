import Testing

@testable import Formidable

struct MaxLengthRuleTests {
 
    private let error = TestError.validationError
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = MaxLengthRule(in: 10, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsLessThanOrEqualReferenceValue() throws {
        let rule = MaxLengthRule(in: 10, error: error)
        
        try rule.validate(10)
        try rule.validate(9)
    }
    
    @Test func mustBeInvalidWhenValueIsGreaterThanReferenceValue() throws {
        let rule = MaxLengthRule(in: 10, error: error)
        
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
