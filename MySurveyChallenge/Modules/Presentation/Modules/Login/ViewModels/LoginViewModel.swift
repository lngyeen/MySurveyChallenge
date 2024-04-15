//
//  LoginViewModel.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Combine
import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username: String = "" {
        didSet {
            if username != oldValue {
                loginErrorMsg = nil
            }
        }
    }

    @Published var password: String = "" {
        didSet {
            if password != oldValue {
                loginErrorMsg = nil
            }
        }
    }

    @Published var loginButtonEnabled: Bool = false
    @Published var loginErrorMsg: String?
    @Published var loggedIn: Bool = false
    @Published var isLoggingIn: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let loginUseCase: LoginUseCase
    private let authenticationManager: AuthenticationManager

    init(loginUseCase: LoginUseCase, authenticationManager: AuthenticationManager) {
        self.loginUseCase = loginUseCase
        self.authenticationManager = authenticationManager

        Publishers.CombineLatest($username, $password)
            .map { username, password in
                !username.isEmpty && !password.isEmpty
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.loginButtonEnabled, on: self)
            .store(in: &cancellables)
    }

    func login() {
        guard !isLoggingIn, !username.isEmpty, !password.isEmpty else {
            return
        }

        isLoggingIn = true
        loginErrorMsg = nil

        loginUseCase.loginWith(email: username, password: password)
            .sink(receiveValue: { result in
                self.isLoggingIn = false
                switch result {
                case .success:
                    self.loggedIn = true
                case .failure(let error):
                    switch error {
                    case .networking(_,
                                     let serverError,
                                     _):
                        withAnimation {
                            self.loginErrorMsg = serverError?.localizedDescription ?? "Something went wrong"
                        }

                    case .noInternet:
                        withAnimation {
                            self.loginErrorMsg = "No internet connection"
                        }

                    case .other:
                        self.loginErrorMsg = "Something went wrong"
                    }
                }
            })
            .store(in: &cancellables)
    }
}
