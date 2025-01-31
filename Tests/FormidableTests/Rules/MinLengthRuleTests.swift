import Testing

@testable import Formidable

struct MinLengthRuleTests {
 
    private let error = TestError.minLength
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = MinLengthRule<Any, Int>(in: 10, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValidateValueIsNilUsingKeyPath() throws {
        let game = Game(10)
        let rule = MinLengthRule(game, keyPath: \.rating, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsGraterThanReferenceValue() throws {
        let rule = MinLengthRule<Any, Int>(in: 10, error: error)
        
        try rule.validate(11)
    }
    
    @Test func mustBeInvalidWhenValueIsLessThanReferenceValue() throws {
        let rule = MinLengthRule<Any, Int>(in: 10, error: error)
        
        #expect(throws: error) {
            try rule.validate(9)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueIsGraterThanReferenceValue() throws {
        let game = Game(10)
        let rule = MinLengthRule(
            game,
            keyPath: \.rating,
            error: error
        )
        
        try rule.validate(11)
    }
    
    @Test func mustBeInvalidWhenKeyPathValueIsLessThanReferenceValue() throws {
        let game = Game(10)
        let rule = MinLengthRule(
            game,
            keyPath: \.rating,
            error: error
        )
        
        #expect(throws: error) {
            try rule.validate(2)
        }
    }
    
}

fileprivate struct Game {
    
    let rating: Int
    
    init(_ rating: Int) {
        self.rating = rating
    }
    
}
