//
//  ContentView.swift
//  FormidableDemo
//
//  Created by Adriano Costa on 30/01/25.
//

import SwiftUI
import Formidable

struct ContentView: View {
    
    @State private var form = SignUpForm(.new)
    
    var body: some View {
        NavigationStack {
            Form {
                TextField(
                    "Name",
                    text: $form.nameField.value
                )
                .field($form.nameField)
                
                TextField(
                    "E-mail",
                    text: $form.emailField.value
                )
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .field($form.emailField)
                
                TextField(
                    "Password",
                    text: $form.passwordField.value
                )
                .privacySensitive()
                .field($form.passwordField)
                
                DatePicker(
                    "Birth",
                    selection: $form.birthField.value,
                    displayedComponents: .date
                )
                .field($form.birthField)
            }
            .navigationTitle("SignUp")
            .toolbar {
                ToolbarItemGroup {
                    Button(action: save) {
                        Text("Save")
                    }
                }
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func save() {
        do {
            let user = try form.submit()
            print(user)
        } catch {}
    }
    
}

#Preview {
    ContentView()
}
