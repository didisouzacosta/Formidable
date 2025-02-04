import Testing

@testable import Formidable

struct EqualKeyPathRuleTests {
 
    private let error = TestError.validationError
    private var game = Game(100)
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = EqualKeyPathRule(game, keyPath: \.score, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsEqual() throws {
        let game = Game(100)
        let rule = EqualKeyPathRule(game, keyPath: \.score, error: error)
        
        try rule.validate(100)
        
        game.score = 50
        
        try rule.validate(50)
    }
    
    @Test func mustBeInvalidWhenValueIsNotEqual() throws {
        var rule = EqualKeyPathRule(game, keyPath: \.score, error: error)

        #expect(throws: error) {
            try rule.validate(99)
        }
        
        rule.transform = { $0 + 10 }
        
        try rule.validate(110)
    }
    
}

fileprivate final class Game {
    
    var score: Int
    
    init(_ score: Int) {
        self.score = score
    }
    
}
