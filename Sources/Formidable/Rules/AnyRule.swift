//
//  AnyRule.swift
//  Formidable
//
//  Created by Adriano Costa on 17/01/25.
//

struct AnyRule: FormFieldRule {

    // MARK: - Private Properties

    private let validateValue: (Any?) throws -> Void

    // MARK: - Initializer

    init<Rule: FormFieldRule>(_ rule: Rule) {
        self.validateValue = { value in
            try rule.validate(value as? Rule.Value)
        }
    }

    // MARK: - Public Methods

    func validate(_ value: Any?) throws {
        try validateValue(value)
    }

}
