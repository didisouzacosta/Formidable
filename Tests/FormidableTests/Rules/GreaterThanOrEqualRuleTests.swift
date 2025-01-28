import Testing

@testable import Formidable

struct GreaterThanOrEqualRuleTests {
 
    private let error = TestError.valueAreNotGreaterThanOrEqual
    
    @Test func mustBeValidWhenValueIsGreaterThanOrEqual() throws {
        let rule = GreaterThanOrEqualRule<Any, Int>(20, error: error)
        
        try rule.validate(21)
        try rule.validate(20)
    }
    
    @Test func mustBeInvalidWhenValueIsNotGreaterThanOrEqual() {
        let rule = GreaterThanOrEqualRule<Any, Int>(10, error: error)

        #expect(throws: error) {
            try rule.validate(9)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueIsGreaterThanOrEqual() throws {
        let person = Person(36)
        let rule = LessThanOrEqualRule(person, keyPath: \.age, error: error)
        
        try rule.validate(35)
        try rule.validate(36)
    }
    
    @Test func mustBeInvalidWhenKeyPathValueIsNotGreaterThanOrEqual() throws {
        let person = Person(36)
        let rule = LessThanOrEqualRule(person, keyPath: \.age, error: error)
        
        #expect(throws: error) {
            try rule.validate(37)
        }
    }
    
    @Test func mustBeValidWhenKeyPathValueIsGreaterThanOrEqualUsingTransformer() throws {
        let person = Person(40)
        let rule = GreaterThanOrEqualRule(
            person,
            keyPath: \.age,
            transform: { $0 + 1 },
            error: error
        )
        
        try rule.validate(41)
        try rule.validate(42)
    }
    
    @Test func mustBeInvalidWhenKeyPathValueIsNotGreaterThanOrEqualUsingTransformer() throws {
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
