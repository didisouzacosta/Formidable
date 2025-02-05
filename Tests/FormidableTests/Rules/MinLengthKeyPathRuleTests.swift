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
        
        try rule.validate("Orlando")
        try rule.validate("Lando")
    }
    
    @Test func mustBeInvalidWhenValueIsLessThanReferenceValue() throws {
        let user = User("Orlando")
        let rule = MinLengthKeyPathRule(user, keyPath: \.name, error: error)
        
        #expect(throws: error) {
            try rule.validate("Orlando Bolotari Costa")
        }
    }
    
}

fileprivate class User {
    
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
}
