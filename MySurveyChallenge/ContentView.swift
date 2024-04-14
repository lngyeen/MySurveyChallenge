//
//  ContentView.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            backgroundView

            Text("Hello, world!")
                .font(Font(R.font.neuzeitSLTStdBookHeavy(size: 34)!))
                .foregroundColor(Color(R.color.colorDefaultOnSurfaceInverted))
        }
        .edgesIgnoringSafeArea(.all)
    }

    private var backgroundView: some View {
        GeometryReader { geo in
            Image(R.image.splash)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
