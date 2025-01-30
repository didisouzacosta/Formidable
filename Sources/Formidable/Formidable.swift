import SwiftUI

/// A protocol representing an object that can be validated and reset, typically used for form-like structures.
///
/// The `Formidable` protocol is intended for objects that contain form fields, offering common functionality
/// such as validation, error handling, and field resetting. It ensures that any object conforming to it can
/// handle these operations consistently, making it easier to manage form-like structures in the UI.
///
/// The protocol is marked with `@MainActor`, ensuring that the operations occur on the main thread.
///
/// ## Example Usage
///
/// ```swift
/// @Observable
/// struct UserForm: Formidable {
///     var name: FormFieldValue<String>
///     var age: FormFieldValue<Int>
///
///     init(name: String, age: Int) {
///         self.name = FormFieldValue(name)
///         self.age = FormFieldValue(age)
///     }
/// }
///
/// let form = UserForm(name: "John", age: 30)
/// do {
///     try form.validate() // Throws error if any field validation fails
/// } catch {
///     print("Validation failed: \(error)")
/// }
///
/// form.reset() // Resets the form fields to their original values
/// ```
public protocol Formidable: ObservableObject {}

public extension Formidable {
    
    /// Validates the fields of the form, setting `showErrors` to `true` for each field.
    /// Throws the first error encountered in the fields, if any.
    ///
    /// - Throws: The first error from the form fields, if any.
    func validate() throws {
        fields.forEach { $0.showErrors = true }
        if let error = errors.first {
            throw error
        }
    }
    
    /// Resets all fields in the form to their initial values, clearing any errors.
    func reset() {
        fields.forEach { $0.reset() }
    }
    
    /// A computed property that indicates whether all form fields are valid.
    /// Returns `true` if there are no errors, `false` otherwise.
    var isValid: Bool {
        errors.isEmpty
    }
    
    /// A computed property that indicates whether all form fields are modified
    /// Returns `true` if there are modified, `false` otherwise.
    var isModified: Bool {
        fields.contains { $0.isModified }
    }
    
    /// A computed property that gathers all errors from the form fields.
    /// Returns an array of errors, with each error potentially coming from a different field.
    var errors: [Error] {
        fields.flatMap { $0.errors.compactMap { $0 } }
    }
    
    // MARK: - Private Properties
    
    /// A private computed property that collects all form fields from the conforming object.
    /// Uses reflection to find properties that conform to the `FormField` protocol.
    ///
    /// - Returns: An array of form fields that are part of the conforming object.
    var fields: [any FormFieldRepresentable] {
        Mirror(reflecting: self).children.compactMap { $0.value as? any FormFieldRepresentable }
    }
    
}

