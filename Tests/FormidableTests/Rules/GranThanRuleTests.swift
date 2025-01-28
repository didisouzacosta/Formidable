import Testing

@testable import Formidable

struct GranThanRuleTests {
 
    private let error = TestError.valueAreNotGreather
    
    @Test func mustBeValidWhenValueIsGreather() throws {
        let rule = GreatherThanRule<Any, Int>(100, error: error)
        try rule.validate(101)
    }
    
    @Test func mustBeInvalidWhenValueIsNotGreather() {
        let rule = GreatherThanRule<Any, Int>(10, error: error)

        #expect(throws: error) {
            try rule.validate(9)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueIsGreather() throws {
        let person = Person(36)
        let rule = GreatherThanRule(person, keyPath: \.age, error: error)
        
        try rule.validate(37)
    }
    
    @Test func mustBeInvalidWhenKeyPathValueIsNotGreather() throws {
        let person = Person(36)
        let rule = EqualRule(person, keyPath: \.age, error: error)
        
        #expect(throws: error) {
            try rule.validate(40)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueIsGreatherUsingTransformer() throws {
        let person = Person(36)
        let rule = EqualRule(
            person,
            keyPath: \.age,
            transform: { $0 + 4 },
            error: error
        )
        
        try rule.validate(40)
    }
    
    @Test func mustBeInvalidWhenKeyPathValueIsNotGreatherUsingTransformer() throws {
        let person = Person(36)
        let rule = EqualRule(
            person,
            keyPath: \.age,
            transform: { $0 + 1 },
            error: error
        )
        
        #expect(throws: error) {
            try rule.validate(50)
        }
    }
    
}

fileprivate struct Person {
    
    let age: Int
    
    init(_ age: Int) {
        self.age = age
    }
    
}
