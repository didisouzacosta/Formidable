import Testing

@testable import Formidable

struct EqualRuleTests {
 
    private let error = TestError.valuesAreNotEqual
    
    @Test func equalRuleWithStaticValueEqual() throws {
        let rule = EqualRule<Any, Int>(10, error: error)
        try rule.validate(10)
    }
    
    @Test func equalRuleWithStaticValueNotEqual() {
        let rule = EqualRule<Any, Int>(10, error: error)

        #expect(throws: error) {
            try rule.validate(5)
        }
    }
    
    @Test func equalRuleWithKeyPathValueEqual() throws {
        let person = Person("Orlando")
        let rule = EqualRule(person, keyPath: \.name, error: error)
        
        try rule.validate("Orlando")
    }
    
    @Test func equalRuleWithKeyPathValueNotEqual() throws {
        let person = Person("Orlando")
        let rule = EqualRule(person, keyPath: \.name, error: error)
        
        #expect(throws: error) {
            try rule.validate("orlando")
        }
    }
    
    @Test func equalRuleWithKeyPathValueEqualUsingTransformer() throws {
        let person = Person("Orlando")
        let rule = EqualRule(
            person,
            keyPath: \.name,
            transform: { $0 + " Bolotari Costa" },
            error: error
        )
        
        try rule.validate("Orlando Bolotari Costa")
    }
    
    @Test func equalRuleWithKeyPathValueNotEqualUsingTransformer() throws {
        let person = Person("Orlando")
        let rule = EqualRule(
            person,
            keyPath: \.name,
            transform: { $0 + " Bolotari Costa" },
            error: error
        )
        
        #expect(throws: error) {
            try rule.validate("orlando costa")
        }
    }
    
}

fileprivate struct Person {
    
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
}
