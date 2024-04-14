//
//  InputFieldModifier.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import SwiftUI

struct InputFieldModifier: ViewModifier {
    var borderColor = Color.gray

    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding([.horizontal], 12)
            .frame(height: 56)
            .background(Color.white.opacity(0.28))
            .cornerRadius(12)
            .foregroundStyle(Color(R.color.colorDefaultOnSurfaceInverted))
            .tint(Color(R.color.colorDefaultOnSurfaceInverted))
    }
}

extension View {
    func inputField() -> some View {
        modifier(InputFieldModifier())
    }
}
