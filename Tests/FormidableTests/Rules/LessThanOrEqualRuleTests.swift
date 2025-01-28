import Testing

@testable import Formidable

struct LessThanOrEqualRuleTests {
 
    private let error = TestError.valueAreNotLessThanOrEqual
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = LessThanOrEqualRule<Any, Int>(20, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValidateValueIsNilUsingKeyPath() throws {
        let person = Person(36)
        let rule = LessThanOrEqualRule(person, keyPath: \.age, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsLessThanOrEqual() throws {
        let rule = LessThanOrEqualRule<Any, Int>(20, error: error)
        
        try rule.validate(20)
        try rule.validate(19)
    }
    
    @Test func mustBeInvalidWhenValueIsNotLessThanOrEqual() {
        let rule = LessThanOrEqualRule<Any, Int>(10, error: error)

        #expect(throws: error) {
            try rule.validate(11)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueIsLessThanOrEqual() throws {
        let person = Person(36)
        let rule = LessThanOrEqualRule(person, keyPath: \.age, error: error)
        
        try rule.validate(35)
        try rule.validate(36)
    }
    
    @Test func mustBeInvalidWhenKeyPathValueIsNotLessThanOrEqual() throws {
        let person = Person(36)
        let rule = LessThanOrEqualRule(person, keyPath: \.age, error: error)
        
        #expect(throws: error) {
            try rule.validate(37)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueIsLessThanOrEqualUsingTransformer() throws {
        let person = Person(40)
        let rule = LessThanOrEqualRule(
            person,
            keyPath: \.age,
            transform: { $0 + 1 },
            error: error
        )
        
        try rule.validate(40)
        try rule.validate(41)
    }
    
    @Test func mustBeInvalidWhenKeyPathValueIsNotLessThanOrEqualUsingTransformer() throws {
        let person = Person(40)
        let rule = LessThanRule(
            person,
            keyPath: \.age,
            transform: { $0 - 1 },
            error: error
        )
        
        #expect(throws: error) {
            try rule.validate(40)
        }
    }
    
}

fileprivate struct Person {
    
    let age: Int
    
    init(_ age: Int) {
        self.age = age
    }
    
}
