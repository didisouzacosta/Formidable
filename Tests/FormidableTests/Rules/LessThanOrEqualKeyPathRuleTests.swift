import Testing

@testable import Formidable

struct LessThanOrEqualKeyPathRuleTests {
 
    private let error = TestError.areNotEqual
    private var game = Game(100)
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = LessThanOrEqualKeyPathRule(game, keyPath: \.score, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsLessThanOrEqual() throws {
        let game = Game(100)
        let rule = LessThanOrEqualKeyPathRule(game, keyPath: \.score, error: error)
        
        try rule.validate(100)
        
        game.score = 50
        
        try rule.validate(49)
    }
    
    @Test func mustBeInvalidWhenValueIsNotLessThanOrEqual() throws {
        let rule = LessThanOrEqualKeyPathRule(game, keyPath: \.score, error: error)

        #expect(throws: error) {
            try rule.validate(101)
        }
    }
    
}

fileprivate final class Game {
    
    var score: Int
    
    init(_ score: Int) {
        self.score = score
    }
    
}
