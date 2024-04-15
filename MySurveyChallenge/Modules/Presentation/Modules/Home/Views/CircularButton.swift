//
//  CircularButton.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import SwiftUI

struct CircularButton<Content: View>: View {
    let icon: () -> Content
    let action: () -> Void
    let size: CGFloat

    init(action: @escaping () -> Void,
         @ViewBuilder icon: @escaping () -> Content,
         size: CGFloat = 56)
    {
        self.action = action
        self.icon = icon
        self.size = size
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: size,
                           height: size)

                icon()
            }
        }
    }
}

#Preview {
    ZStack {
        Color(R.color.colorDefaultBackgroundDark)
        CircularButton(action: {}) {
            Image(R.image.arrow)
        }
    }
}
