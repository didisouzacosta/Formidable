import Testing

@testable import Formidable

struct LessThanRuleTests {
 
    private let error = TestError.valueAreNotLess
    
    @Test func mustBeValidWhenValueIsLess() throws {
        let rule = LessThanRule<Any, Int>(20, error: error)
        try rule.validate(19)
    }
    
    @Test func mustBeInvalidWhenValueIsNotLess() {
        let rule = LessThanRule<Any, Int>(10, error: error)

        #expect(throws: error) {
            try rule.validate(11)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueIsLessOrEqual() throws {
        let person = Person(36)
        let rule = LessThanOrEqualRule(person, keyPath: \.age, error: error)
        
        try rule.validate(36)
        try rule.validate(35)
    }
    
    @Test func mustBeInvalidWhenKeyPathValueIsNotLessOrEqual() throws {
        let person = Person(36)
        let rule = LessThanOrEqualRule(person, keyPath: \.age, error: error)
        
        #expect(throws: error) {
            try rule.validate(37)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueIsLessOrEqualUsingTransformer() throws {
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
    
    @Test func mustBeInvalidWhenKeyPathValueIsNotLessOrEqualUsingTransformer() throws {
        let person = Person(40)
        let rule = LessThanOrEqualRule(
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
