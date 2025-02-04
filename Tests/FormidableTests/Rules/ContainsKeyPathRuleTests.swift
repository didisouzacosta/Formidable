import Testing

@testable import Formidable

struct ContainsKeyPathRuleTests {
 
    private let error = TestError.validationError
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let game = Game(["Link", "Zelda", "Ganondorf"])
        let rule = ContainsKeyPathRule(game, keyPath: \.characters, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenTheCollectionContainsTheValue() throws {
        let game = Game(["Link", "Zelda", "Ganondorf"])
        var rule = ContainsKeyPathRule(game, keyPath: \.characters, error: error)
        
        try rule.validate("Link")
        
        rule.transform = { $0.map { $0.lowercased() } }
        
        try rule.validate("zelda")
    }
    
    @Test func mustBeInvalidWhenTheCollectionNotContainsTheValue() throws {
        let game = Game(["Link", "Zelda", "Ganondorf"])
        let rule = ContainsKeyPathRule(game, keyPath: \.characters, error: error)
        
        #expect(throws: error) {
            try rule.validate("Impa")
        }
    }
    
}

fileprivate class Game {
    
    let characters: [String]
    
    init(_ characters: [String]) {
        self.characters = characters
    }
    
}
