//
//  DataDI.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

class DataInstanceAssembly: InstanceAssembly {
    func assemble(container: Container) {
        container.register(LocalStoreService.self) { _ in
            LocalStoreServiceImpl()
        }

        container.register(LoginDataProvider.self) { _ in
            LoginDataProviderImpl(networkAPIClient: NetworkAPIClientProvider.clientForType(.basic))
        }

        container.register(LoginRepository.self) {
            LoginRepositoryImpl(dataProvider: $0.resolve(LoginDataProvider.self)!)
        }

        container.register(SurveyDataProvider.self) { _ in
            SurveyDataProviderImpl(networkAPIClient: NetworkAPIClientProvider.clientForType(.basic))
        }

        container.register(SurveyRepository.self) {
            SurveyRepositoryImpl(dataProvider: $0.resolve(SurveyDataProvider.self)!)
        }
    }
}
