import Testing

@testable import Formidable

struct MinLengthRuleTests {
 
    private let error = TestError.minLength
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = MinLengthRule<Any, Int>(in: 10, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValidateValueIsNilUsingKeyPath() throws {
        let game = Game(36)
        let rule = MinLengthRule(game, keyPath: \.rating, error: error)
        
        try rule.validate(nil)
    }
    
}

fileprivate struct Game {
    
    let rating: Int
    
    init(_ rating: Int) {
        self.rating = rating
    }
    
}
