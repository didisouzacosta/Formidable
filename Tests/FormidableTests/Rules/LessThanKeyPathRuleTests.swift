import Testing

@testable import Formidable

struct LessThanKeyPathRuleTests {
 
    private let error = TestError.validationError
    private var game = Game(100)
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = LessThanKeyPathRule(game, keyPath: \.score, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsLessThan() throws {
        let game = Game(100)
        let rule = LessThanKeyPathRule(game, keyPath: \.score, error: error)
        
        try rule.validate(99)
        
        game.score = 50
        
        try rule.validate(49)
    }
    
    @Test func mustBeInvalidWhenValueIsNotLessThan() throws {
        var rule = LessThanKeyPathRule(game, keyPath: \.score, error: error)

        #expect(throws: error) {
            try rule.validate(100)
        }
        
        rule.transform = { $0 + 10 }
        
        #expect(throws: error) {
            try rule.validate(110)
        }
    }
    
}

fileprivate final class Game {
    
    var score: Int
    
    init(_ score: Int) {
        self.score = score
    }
    
}
