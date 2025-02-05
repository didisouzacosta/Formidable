import Testing

@testable import Formidable

struct MaxLengthKeyPathRuleTests {
 
    private let error = TestError.validationError
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let user = User("Orlando")
        let rule = MaxLengthKeyPathRule(user, keyPath: \.name, error: error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueIsGraterThanOrEqualReferenceValue() throws {
        let user = User("Orlando")
        let rule = MaxLengthKeyPathRule(user, keyPath: \.name, error: error)
        
        try rule.validate("Orlando")
        try rule.validate("Orlando Bolotari Costa")
    }
    
    @Test func mustBeInvalidWhenValueIsLessThanReferenceValue() throws {
        let user = User("Orlando")
        let rule = MaxLengthKeyPathRule(user, keyPath: \.name, error: error)
        
        #expect(throws: error) {
            try rule.validate("Lando")
        }
    }
    
}

fileprivate class User {
    
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
}
