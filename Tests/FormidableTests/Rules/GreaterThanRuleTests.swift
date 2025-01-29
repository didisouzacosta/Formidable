import Testing

@testable import Formidable

struct GreaterThanRuleTests {
 
    private let error = TestError.areNotGreater
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = GreaterThanRule<Any, Int>(20, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValidateValueIsNilUsingKeyPath() throws {
        let person = Person(36)
        let rule = GreaterThanRule(person, keyPath: \.age, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsGreather() throws {
        let rule = GreaterThanRule<Any, Int>(100, error: error)
        
        try rule.validate(101)
    }
    
    @Test func mustBeInvalidWhenValueIsNotGreater() {
        let rule = GreaterThanRule<Any, Int>(10, error: error)

        #expect(throws: error) {
            try rule.validate(9)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueIsGreater() throws {
        let person = Person(36)
        let rule = GreaterThanRule(person, keyPath: \.age, error: error)
        
        try rule.validate(37)
    }
    
    @Test func mustBeInvalidWhenKeyPathValueIsNotGreater() throws {
        let person = Person(36)
        let rule = EqualRule(person, keyPath: \.age, error: error)
        
        #expect(throws: error) {
            try rule.validate(40)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueIsGreaterUsingTransformer() throws {
        let person = Person(36)
        let rule = EqualRule(
            person,
            keyPath: \.age,
            transform: { $0 + 4 },
            error: error
        )
        
        try rule.validate(40)
    }
    
    @Test func mustBeInvalidWhenKeyPathValueIsNotGreaterUsingTransformer() throws {
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
