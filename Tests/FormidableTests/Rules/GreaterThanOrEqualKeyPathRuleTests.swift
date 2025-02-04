import Testing

@testable import Formidable

struct GreaterThanOrEqualKeyPathRuleTests {
 
    private let error = TestError.validationError
    private var game = Game(100)
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = GreaterThanOrEqualKeyPathRule(game, keyPath: \.score, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsGreaterThanOrEqual() throws {
        let game = Game(100)
        let rule = GreaterThanOrEqualKeyPathRule(game, keyPath: \.score, error: error)
        
        try rule.validate(100)
        
        game.score = 50
        
        try rule.validate(51)
    }
    
    @Test func mustBeInvalidWhenValueIsNotGreaterThanOrEqual() throws {
        var rule = GreaterThanOrEqualKeyPathRule(game, keyPath: \.score, error: error)

        #expect(throws: error) {
            try rule.validate(99)
        }
        
        rule.transform = { $0 + 10 }
        
        #expect(throws: error) {
            try rule.validate(109)
        }
    }
    
}

fileprivate final class Game {
    
    var score: Int
    
    init(_ score: Int) {
        self.score = score
    }
    
}
