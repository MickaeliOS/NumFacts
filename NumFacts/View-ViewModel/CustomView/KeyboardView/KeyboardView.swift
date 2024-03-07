//
//  KeyboardView.swift
//  NumFacts
//
//  Created by Mickaël Horn on 23/01/2024.
//

import SwiftUI

struct KeyboardView: View {
    // MARK: - PROPERTIES
    @Binding var string: String

    // MARK: - BODY
    var body: some View {
        VStack {
            KeyPadRowView(keys: ["1", "2", "3"])
            KeyPadRowView(keys: ["4", "5", "6"])
            KeyPadRowView(keys: ["7", "8", "9"])
            KeyPadRowView(keys: ["AC", "0", "⌫"])
        }
        .environment(\.keyPadButtonAction, self.keyWasPressed(_:))
    }

    // MARK: - FUNCTIONS
    private func keyWasPressed(_ key: String) {
        switch key {
        case "AC":
            string = ""
        case "⌫":
            if !string.isReallyEmpty {
                string.removeLast()
            }

        // If string == 0, any new pressed key will replace the 0.
        // For example, instead of having 09, you'll have 9.
        case _ where string == "0": string = key
        default: string += key
        }
    }
}

// MARK: - PREVIEW
#Preview {
    KeyboardView(string: .constant("1"))
}
