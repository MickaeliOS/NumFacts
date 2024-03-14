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
    @Binding var loadingFact: Bool

    // MARK: - BODY
    var body: some View {
        ZStack {
            VStack {
                Text(message ?? "Enter a number to get a cool fact about it !")
                    .foregroundStyle(Color(.font))
                    .font(.title3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }

            VStack {
                Spacer()

                if loadingFact {
                    ProgressView()
                        .padding(.bottom)
                        .progressViewStyle(CircularProgressViewStyle(tint: .background))
                        .scaleEffect(1.5)
                }
            }
        }
        .frame(width: width, height: height)
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
    CustomTextView(width: 300.0, height: 30.0, loadingFact: .constant(true))
}
