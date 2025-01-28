import Testing

@testable import Formidable

struct UniqueRuleTests {
 
    private let error = TestError.valueNotIsUnique
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = UniqueRule<Any, Int>(in: [10], error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValidateValueIsNilUsingKeyPath() throws {
        let game = Game([36])
        let rule = UniqueRule(game, keyPath: \.values, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsUnique() throws {
        let rule = UniqueRule<Any, Int>(in: [10], error: error)
        
        try rule.validate(11)
    }
    
    @Test func mustBeInvalidWhenValueIsNotUnique() throws {
        let rule = UniqueRule<Any, Int>(in: [10, 11, 12], error: error)
        
        #expect(throws: error) {
            try rule.validate(11)
        }
    }
    
}

fileprivate struct Game {
    
    let values: [Int]
    
    init(_ values: [Int]) {
        self.values = values
    }
    
}
