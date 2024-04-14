//
//  LoginDI.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

class LoginInstanceAssembly: InstanceAssembly {
    func assemble(container: Container) {
        container.register(LoginViewModel.self) { _ in
            LoginViewModel()
        }
    }
}
