import Testing

@testable import Formidable

@MainActor
struct UniqueKeyPathRuleTests {

    private let error = TestError.validationError

    @Test func nilValueIsValid() throws {
        let root = UniqueValues(["existing"])
        let rule = UniqueKeyPathRule(root, keyPath: \.values, error: error)

        try rule.validate(nil)
    }

    @Test func uniqueValueIsValid() throws {
        let root = UniqueValues(["existing"])
        let rule = UniqueKeyPathRule(root, keyPath: \.values, error: error)

        try rule.validate("new")
    }

    @Test func duplicateValueIsInvalid() {
        let root = UniqueValues(["existing"])
        let rule = UniqueKeyPathRule(root, keyPath: \.values, error: error)

        #expect(throws: error) {
            try rule.validate("existing")
        }
    }

    @Test func transformIsAppliedToReferenceValues() {
        let root = UniqueValues(["EXISTING"])
        let rule = UniqueKeyPathRule(
            root,
            keyPath: \.values,
            error: error,
            transform: { $0.map { $0.lowercased() } }
        )

        #expect(throws: error) {
            try rule.validate("existing")
        }
    }

    @Test func referenceRootUpdatesAreReadDynamically() throws {
        let root = UniqueValues(["existing"])
        let rule = UniqueKeyPathRule(root, keyPath: \.values, error: error)

        try rule.validate("new")

        root.values.append("new")

        #expect(throws: error) {
            try rule.validate("new")
        }
    }

}

fileprivate final class UniqueValues {

    var values: [String]

    init(_ values: [String]) {
        self.values = values
    }

}
