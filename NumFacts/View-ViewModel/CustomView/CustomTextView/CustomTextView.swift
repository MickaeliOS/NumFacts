//
//  CustomTextView.swift
//  NumFacts
//
//  Created by Mickaël Horn on 06/02/2024.
//

import SwiftUI

struct CustomTextView: View {
    // MARK: - PROPERTIES
    var message: String?
    var width: Double
    var height: Double

    // MARK: - BODY
    var body: some View {
        Text(message ?? "Enter a number to get a cool fact about it !")
            .foregroundStyle(Color(.font))
            .font(.title3)
            .frame(width: width,
                   height: height)
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [
                    Color.white,
                    Color(.textBackground)
                ]), startPoint: .top, endPoint: .bottom)
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - PREVIEW
#Preview {
    CustomTextView(width: 300.0, height: 30.0)
}
