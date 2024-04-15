//
//  DeviceDI.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import Foundation

class DeviceSingletonAssembly: SingletonAssembly {
    func assemble(container: Container) {
        container.register(KeychainFrameworkAdapter.self) { _ in
            KeychainFrameworkAdapterImpl()
        }

        container.register(SecureStoreService.self) {
            KeychainStoreService(adapter: $0.resolve(KeychainFrameworkAdapter.self)!)
        }
    }
}
