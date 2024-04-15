//
//  ErrorView.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import SwiftUI

struct ErrorView: View {
    enum Constants {
        static let buttonHeight = CGFloat(56)
    }

    let errorMessage: String
    let retryAction: () -> Void

    var body: some View {
        VStack {
            Text(errorMessage)
                .font(Font(R.font.neuzeitSLTStdBook(size: 21)!))
                .foregroundColor(Color(R.color.colorDefaultOnSurfaceSubdued))

            Button(action: {
                retryAction()
            }) {
                Text("Try again")
                    .frame(height: Constants.buttonHeight)
                    .padding(.horizontal, 30)
                    .foregroundColor(Color(R.color.colorDefaultOnSurface))
                    .background(Color(R.color.colorDefaultBackground))
                    .cornerRadius(10)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ErrorView(errorMessage: "Something went wrong!", retryAction: {})
        .background(Color(R.color.colorDefaultBackgroundDark))
}
