import Testing

@testable import Formidable

struct GreaterThanRuleTests {
 
    private let error = TestError.areNotGreater
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = GreaterThanRule(20, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsGreather() throws {
        let rule = GreaterThanRule(100, error: error)
        
        try rule.validate(101)
    }
    
    @Test func mustBeInvalidWhenValueIsNotGreater() {
        let rule = GreaterThanRule(10, error: error)

        #expect(throws: error) {
            try rule.validate(9)
        }
    }
    
}

fileprivate struct Person {
    
    let age: Int
    
    init(_ age: Int) {
        self.age = age
    }
    
}
