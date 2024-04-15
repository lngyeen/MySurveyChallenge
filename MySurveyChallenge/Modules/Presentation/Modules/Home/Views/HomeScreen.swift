//
//  HomeScreen.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack {
            Text("Hello, World!")

            logoutButton
        }
    }

    private var logoutButton: some View {
        Button(action: {
            DI.singleton.resolve(AuthenticationManager.self)!.removeCredentials()
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("Log out")
        }
        .padding()
    }
}

#Preview {
    HomeScreen()
}
