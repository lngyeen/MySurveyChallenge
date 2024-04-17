//
//  HomeViewModel.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/16/24.
//

import Combine
import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    enum Constants {
        static let pageNumer = Int(1)
        static let pageSize = Int(10)
    }

    @Published var surveys: [Survey] = []
    @Published var isLoading: Bool = false
    @Published var errorMsg: String?
    @Published var showAuthenticationAlert: Bool = false

    private var didFetchData = false

    private let getSurveysUseCase: GetSurveysUseCase
    private let authenticationManager: AuthenticationManager
    private var cancellables = Set<AnyCancellable>()

    init(getSurveysUseCase: GetSurveysUseCase, authenticationManager: AuthenticationManager) {
        self.getSurveysUseCase = getSurveysUseCase
        self.authenticationManager = authenticationManager
    }

    func logout() {
        authenticationManager.removeCredentials()
    }

    func fetchSurveys() {
        guard !isLoading else { return }

        isLoading = true
        errorMsg = nil

        getSurveysUseCase.getSurveys(pageNumber: Constants.pageNumer, pageSize: Constants.pageSize)
            .sink { result in
                switch result {
                case .success(let surveys):
                    self.surveys = surveys
                case .failure(let error):
                    switch error {
                    case .networking(let statusCode,
                                     let serverError,
                                     _):
                        switch statusCode {
                        case 401:
                            self.showAuthenticationAlert = true
                        default:
                            self.errorMsg = serverError?.localizedDescription ?? "Something went wrong"
                        }

                    case .noInternet:
                        self.errorMsg = "No internet connection. please check your internet settings"

                    case .other:
                        self.errorMsg = "Something went wrong"
                    }
                }
                withAnimation(.easeIn(duration: 0.5)) {
                    self.isLoading = false
                }
            }
            .store(in: &cancellables)
    }
}
