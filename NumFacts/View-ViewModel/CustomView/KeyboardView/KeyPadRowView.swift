//
//  KeyPadRowView.swift
//  NumFacts
//
//  Created by Mickaël Horn on 23/01/2024.
//

import SwiftUI

struct KeyPadRowView: View {
    // MARK: - PROPERTIES
    var keys: [String]

    // MARK: - BODY
    var body: some View {
        HStack {
            ForEach(keys, id: \.self) { key in
                KeyPadButtonView(key: key)
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    KeyPadRowView(keys: ["1", "2", "3"])
}
