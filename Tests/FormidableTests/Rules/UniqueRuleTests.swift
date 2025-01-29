import Testing

@testable import Formidable

struct UniqueRuleTests {
 
    private let error = TestError.alreadyExists
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = UniqueRule<Any, Int>(in: [10], error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValidateValueIsNilUsingKeyPath() throws {
        let game = Game([36])
        let rule = UniqueRule(game, keyPath: \.values, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueNotExistsYet() throws {
        let rule = UniqueRule<Any, Int>(in: [10], error: error)
        
        try rule.validate(11)
    }
    
    @Test func mustBeInvalidWhenValueAlreadyExists() throws {
        let rule = UniqueRule<Any, Int>(in: [10, 11, 12], error: error)
        
        #expect(throws: error) {
            try rule.validate(11)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueNotExistsYet() throws {
        let game = Game([1, 2, 3, 4])
        let rule = UniqueRule(
            game,
            keyPath: \.values,
            error: error
        )
        
        try rule.validate(11)
    }
    
    @Test func mustBeInvalidWhenKeyPathValueAlreadyExists() throws {
        let game = Game([1, 2, 3, 4])
        let rule = UniqueRule(
            game,
            keyPath: \.values,
            error: error
        )
        
        #expect(throws: error) {
            try rule.validate(2)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueTransformedNotExistsYet() throws {
        let game = Game([1, 2, 3, 4])
        let rule = UniqueRule(
            game,
            keyPath: \.values,
            transform: { $0 + [5, 10, 12] },
            error: error
        )
        
        try rule.validate(11)
    }
    
    @Test func mustBeInvalidWhenKeyPathValueTransformedAlreadyExists() throws {
        let game = Game([1, 2, 3, 4])
        let rule = UniqueRule(
            game,
            keyPath: \.values,
            transform: { $0 + [5, 10, 12] },
            error: error
        )
        
        #expect(throws: error) {
            try rule.validate(12)
        }
    }
    
}

fileprivate struct Game {
    
    let values: [Int]
    
    init(_ values: [Int]) {
        self.values = values
    }
    
}
