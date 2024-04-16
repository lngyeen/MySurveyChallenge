//
//  MySurveyChallengeApp.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import SwiftUI

@main
struct MySurveyChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginScreen(viewModel: DI.instance.resolve(LoginViewModel.self)!)
            }
        }
    }
}
