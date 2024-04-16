//
//  DataDI.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

class DataInstanceAssembly: InstanceAssembly {
    func assemble(container: Container) {
        container.register(LoginRepository.self) { _ in
            LoginRepositoryImpl(networkAPIClient: NetworkAPIClientProvider.clientForType(.basic))
        }

        container.register(SurveyRepository.self) { _ in
            SurveyRepositoryWithCachingImpl(networkAPIClient: NetworkAPIClientProvider.clientForType(.basic),
                                            localStoreService: DI.singleton.resolve(LocalStoreService.self)!)
        }
    }
}
