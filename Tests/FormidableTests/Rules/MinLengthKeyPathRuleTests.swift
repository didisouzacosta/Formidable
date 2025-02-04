import Testing

@testable import Formidable

struct MinLengthKeyPathRuleTests {
 
    private let error = TestError.validationError
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let user = User("Orlando")
        let rule = MinLengthKeyPathRule(user, keyPath: \.name, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsGraterThanOrEqualReferenceValue() throws {
        let user = User("Orlando")
        let rule = MinLengthKeyPathRule(user, keyPath: \.name, error: error)
        
        try rule.validate(7)
        try rule.validate(6)
    }
    
    @Test func mustBeInvalidWhenValueIsLessThanReferenceValue() throws {
        let user = User("Orlando")
        let rule = MinLengthKeyPathRule(user, keyPath: \.name, error: error)
        
        #expect(throws: error) {
            try rule.validate(8)
        }
    }
    
}

fileprivate class User {
    
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
}
