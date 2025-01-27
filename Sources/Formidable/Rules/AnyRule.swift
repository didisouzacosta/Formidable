//
//  AnyRule.swift
//  Formidable
//
//  Created by Adriano Costa on 17/01/25.
//

struct AnyRule: FormFieldRule {
    
    // MARK: - Private Variables
    
    private let _validate: (Any?) throws -> Void
    
    // MARK: - Life Cycle
    
    init<T: FormFieldRule>(_ rule: T) {
        _validate = { value in
            guard let value = value as? T.Value else { return }
            try rule.validate(value)
        }
    }
    
    // MARK: - Public Methods
    
    func validate(_ value: Any?) throws {
        try _validate(value)
    }
    
}
