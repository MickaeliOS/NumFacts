//
//  FactView.swift
//  NumFacts
//
//  Created by Mickaël Horn on 18/01/2024.
//

import SwiftUI

struct FactView: View {
    // MARK: - PROPERTIES
    @StateObject private var viewModel = ViewModel()
    @FocusState private var numberTextFieldIsFocused: Bool

    // MARK: - BODY
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image("NumFacts")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                    .padding([.bottom])

                if let errorMessage = viewModel.errorMessage {
                    CustomTextView(message: errorMessage,
                                   width: geometry.size.width * 0.8,
                                   height: geometry.size.height * 0.3)
                } else {
                    CustomTextView(message: viewModel.fact?.text,
                                   width: geometry.size.width * 0.8,
                                   height: geometry.size.height * 0.3)
                }

                Spacer()

                VStack {
                    TextField("",
                              text: $viewModel.number,
                              prompt: Text("No number entered.").foregroundStyle(.gray)
                    )
                    .disabled(true)
                    .font(.title2)
                    .foregroundStyle(.white)

                    KeyboardView(string: $viewModel.number)
                }
                .font(.largeTitle)
                .padding()
            }
            .background(Color(.background))
        }
    }
}

// MARK: - PREVIEW
#Preview {
    FactView()
}
