import Testing

@testable import Formidable

enum TestError: Error, Equatable {
    case valuesAreNotEqual
}

struct EqualRuleTests {
 
    @Test func equalRuleWithStaticValueEqual() throws {
        let error = TestError.valuesAreNotEqual
        let rule = EqualRule<Any, Int>(10, error: error)
        
        try rule.validate(10)
    }
    
    @Test func equalRuleWithStaticValueNotEqual() {
        let error = TestError.valuesAreNotEqual
        let rule = EqualRule<Any, Int>(10, error: error)
        
        #expect(throws: TestError.valuesAreNotEqual) {
            try rule.validate(5)
        }
    }
    
}
