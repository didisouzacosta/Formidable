import Testing

@testable import Formidable

struct EmailRuleTests {
 
    private let error = TestError.invalidEmail
    
    @Test func mustBeValidWhenValidateValueIsNil() throws {
        let rule = EmailRule(error)
        
        try rule.validate(nil)
    }
    
    @Test func mustBeValidWhenValueBeAValidEmail() throws {
        let rule = EmailRule(error)
        
        try rule.validate("adrianosouzacostaios@gmail.com.br")
        try rule.validate("didisouzacosta@gmail.com")
    }
    
    @Test func mustBeInvalidWhenValueBeAInvalidEmail() throws {
        let rule = EmailRule(error)
        
        #expect(throws: error) {
            try rule.validate("2")
            try rule.validate("")
            try rule.validate("1")
            try rule.validate("@sldkfjds@.com")
        }
    }
    
}
