//
//  KeyPadButtonView.swift
//  NumFacts
//
//  Created by Mickaël Horn on 23/01/2024.
//

import SwiftUI

struct KeyPadButtonView: View {
    // MARK: - PROPERTIES
    @Environment(\.keyPadButtonAction) var action: (String) -> Void
    var key: String

    // MARK: - BODY
    var body: some View {
        Button {
            // If the user presses the "3" key, for example, then the "self.keyWasPressed(_:)"
            // func will be triggered with "3" as its parameter.
            self.action(self.key)
        } label: {
            Color.clear
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                )
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [
                    Color.white,
                    Color(.textBackground)
                ]), startPoint: .top, endPoint: .bottom))
                .overlay(
                    Text(key)
                        .foregroundStyle(Color(.background))
                )
        }
    }

    // MARK: - ENUM
    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }
}

// MARK: - EXTENSION
extension EnvironmentValues {
    var keyPadButtonAction: (String) -> Void {
        // We get the value associated with the key.
        // This is a subscript.
        get { self[KeyPadButtonView.ActionKey.self] }

        // Inside EnvironmentValues, we probably have a data structure which stores every keys - values.
        // Here, we trigger the setter of the EnvironmentValues subscript to store the new value in the data structure.
        set { self[KeyPadButtonView.ActionKey.self] = newValue }
    }
}

// MARK: - PREVIEW
struct KeyPadButton_Previews: PreviewProvider {
    static var previews: some View {
        KeyPadButtonView(key: "8")
            .padding()
            .frame(width: 80, height: 80)
            .previewLayout(.sizeThatFits)
    }
}
