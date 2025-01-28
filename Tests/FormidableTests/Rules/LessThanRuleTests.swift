import Testing

@testable import Formidable

struct LessThanOrEqualRuleTests {
 
    private let error = TestError.valueAreNotLessOrEqual
    
    @Test func mustBeValidWhenValueIsLessOrEqual() throws {
        let rule = LessThanOrEqualRule<Any, Int>(20, error: error)
        try rule.validate(20)
        try rule.validate(19)
    }
    
    @Test func mustBeInvalidWhenValueIsNotLessOrEqual() {
        let rule = LessThanOrEqualRule<Any, Int>(10, error: error)

        #expect(throws: error) {
            try rule.validate(11)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueIsLess() throws {
        let person = Person(36)
        let rule = LessThanRule(person, keyPath: \.age, error: error)
        
        try rule.validate(35)
    }
    
    @Test func mustBeInvalidWhenKeyPathValueIsNotLess() throws {
        let person = Person(36)
        let rule = LessThanRule(person, keyPath: \.age, error: error)
        
        #expect(throws: error) {
            try rule.validate(37)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueIsLessUsingTransformer() throws {
        let person = Person(40)
        let rule = LessThanRule(
            person,
            keyPath: \.age,
            transform: { $0 + 1 },
            error: error
        )
        
        try rule.validate(40)
    }
    
    @Test func mustBeInvalidWhenKeyPathValueIsNotLessUsingTransformer() throws {
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
