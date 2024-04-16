//
//  HomeDI.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Foundation

class HomeInstanceAssembly: InstanceAssembly {
    func assemble(container: Container) {
        container.register(GetSurveysUseCase.self) {
            GetSurveysUseCaseImpl(surveyRepository: $0.resolve(SurveyRepository.self)!)
        }

        container.register(HomeViewModel.self) {
            HomeViewModel(getSurveysUseCase: $0.resolve(GetSurveysUseCase.self)!,
                          authenticationManager: DI.singleton.resolve(AuthenticationManager.self)!)
        }
    }
}
