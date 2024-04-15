//
//  LoginDI.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

class LoginInstanceAssembly: InstanceAssembly {
    func assemble(container: Container) {
        container.register(LoginUseCase.self) {
            LoginUseCaseImpl(loginRepository: $0.resolve(LoginRepository.self)!,
                             authenticationManager: DI.singleton.resolve(AuthenticationManager.self)!)
        }

        container.register(LoginViewModel.self) {
            LoginViewModel(loginUseCase: $0.resolve(LoginUseCase.self)!,
                           authenticationManager: DI.singleton.resolve(AuthenticationManager.self)!)
        }
    }
}
