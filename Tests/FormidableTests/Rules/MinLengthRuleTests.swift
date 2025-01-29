import Testing

@testable import Formidable

struct MinLengthRuleTests {
 
    private let error = TestError.minLength
    
    @Test func mustBeValidWhenValueIsNil() throws {
        let rule = MinLengthRule<Any, Int>(in: 10, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenKeyPathValueIsNil() throws {
        let game = Game(36)
        let rule = MinLengthRule(game, keyPath: \.rating, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeInValidWhenValueLengthIsLessThanTheReference() throws {
        let rule = MinLengthRule<Any, Int>(in: 10, error: error)
        
        #expect(throws: error) {
            try rule.validate(9)
        }
        
        try rule.validate(10)
    }
    
    @Test func mustBeValidWhenKeyPathValueLengthIsLessThanTheReference() throws {
        let game = Game(36)
        let rule = MinLengthRule(game, keyPath: \.rating, error: error)
        
        #expect(throws: error) {
            try rule.validate(33)
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
