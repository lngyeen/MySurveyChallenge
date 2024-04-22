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
        static let firstPageIndex = Int(1)
        static let pageSize = Int(6)
    }

    @Published var surveys: [Survey] = []
    @Published var isLoading: Bool = false
    @Published var errorMsg: String?
    @Published var showAuthenticationAlert: Bool = false

    private var didFetchData = false
    private var hasMoreData = true
    private var currentPage = Constants.firstPageIndex

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
        guard !isLoading, hasMoreData else { return }

        isLoading = true
        errorMsg = nil

        getSurveysUseCase.getSurveys(pageNumber: currentPage, pageSize: Constants.pageSize)
            .sink { result in
                switch result {
                case .success(let response):
                    self.handleResponse(response)
                case .failure(let error):
                    self.handleError(error)
                }
                withAnimation(.easeIn(duration: 0.5)) {
                    self.isLoading = false
                }
            }
            .store(in: &cancellables)
    }

    private func handleResponse(_ response: NetworkResponse<[Survey]>) {
        surveys.append(contentsOf: response.data)

        guard let meta = response.meta else {
            hasMoreData = false
            return
        }

        hasMoreData = meta.page < meta.pages
        currentPage = hasMoreData ? meta.page + 1 : meta.page
    }

    private func handleError(_ error: AppNetworkError) {
        switch error {
        case .networking(let statusCode,
                         let serverError,
                         _):
            switch statusCode {
            case 401:
                showAuthenticationAlert = true
            default:
                errorMsg = serverError?.localizedDescription ?? "Something went wrong"
            }

        case .noInternet:
            errorMsg = "No internet connection. please check your internet settings"

        case .other:
            errorMsg = "Something went wrong"
        }
    }
}
