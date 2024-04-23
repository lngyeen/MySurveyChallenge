//
//  HomeScreen.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import SwiftUI

struct HomeScreen: View {
    enum Constants {
        static let pagesRemainingToLoadMore = Int(3)
    }

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @StateObject var viewModel: HomeViewModel
    @State private var didFetchData = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if viewModel.isLoading, viewModel.surveys.isEmpty {
                LoadingView()
                    .zIndex(1)
            } else if let errorMsg = viewModel.errorMsg {
                ErrorView(errorMessage: errorMsg) {
                    viewModel.fetchSurveys()
                }
                .zIndex(2)
            } else {
                SurveyListView(surveys: viewModel.surveys) { pageIndex in
                    guard pageIndex >= viewModel.surveys.count - Constants.pagesRemainingToLoadMore else { return }
                    viewModel.fetchSurveys()
                }
                .zIndex(3)
            }

            if !viewModel.isLoading || !viewModel.surveys.isEmpty {
                logoutButton
                    .zIndex(4)
            }
        }
        .background(Color(R.color.colorDefaultBackgroundDark))
        .onAppear {
            if !didFetchData {
                didFetchData = true
                viewModel.fetchSurveys()
            }
        }
        .alert("Your session has expired. Please login again.",
               isPresented: $viewModel.showAuthenticationAlert) {
            Button("OK", role: .cancel) {
                logout()
            }
        }
    }

    private var logoutButton: some View {
        Button(action: {
            logout()
        }) {
            Image(R.image.userpic)
        }
        .frame(width: 36, height: 36)
        .contentShape(Circle())
        .padding(.top, 35)
        .padding(.trailing, 20)
        .accessibilityLabel(Text("Log out"))
    }

    private func logout() {
        viewModel.logout()
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    HomeScreen(viewModel: DI.instance.resolve(HomeViewModel.self)!)
}
