//
//  TextErrors.swift
//  Formidable
//
//  Created by Adriano Costa on 15/01/25.
//

import SwiftUI

public struct TextErrors: View {
    
    // MARK: - Private Variables
    
    private let errors: [Error]
    
    private var messages: [String] {
        errors.map { $0.localizedDescription }
    }
    
    // MARK: - Life Cycle
    
    public init(_ errors: [Error]) {
        self.errors = errors
    }
    
    public var body: some View {
        if messages.isEmpty {
            EmptyView()
        } else {
            VStack(alignment: .leading) {
                ForEach(Array(zip(messages.indices, messages)), id: \.0) { index, message in
                    Text(message)
                        .id(index)
                }
            }
            .font(.callout)
            .foregroundStyle(.red)
        }
    }
    
}
