import Testing

@testable import Formidable

struct MaxLengthRuleTests {
 
    private let error = TestError.minLength
    
    @Test func mustBeValidWhenValueIsNil() throws {
        let rule = MaxLengthRule<Any, Int>(in: 10, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenKeyPathValueIsNil() throws {
        let game = Game(36)
        let rule = MaxLengthRule(game, keyPath: \.rating, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeInValidWhenValueLengthIsGreaterThanTheReference() throws {
        let rule = MaxLengthRule<Any, Int>(in: 10, error: error)
        
        #expect(throws: error) {
            try rule.validate(11)
        }
        
        try rule.validate(10)
    }
    
    @Test func mustBeValidWhenKeyPathValueLengthIsGreaterThanTheReference() throws {
        let game = Game(36)
        let rule = MaxLengthRule(game, keyPath: \.rating, error: error)
        
        #expect(throws: error) {
            try rule.validate(37)
        }
        
        try rule.validate(36)
    }
    
}

fileprivate struct Game {
    
    let rating: Int
    
    init(_ rating: Int) {
        self.rating = rating
    }
    
}
