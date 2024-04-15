//
//  AppDI.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

class AppSingletonAssembly: SingletonAssembly {
    func assemble(container: Container) {
        container.register(AuthenticationManager.self) { _ in
            AuthenticationManagerImpl()
        }
    }
}
