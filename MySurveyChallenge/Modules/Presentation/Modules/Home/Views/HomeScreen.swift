//
//  HomeScreen.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/15/24.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @StateObject var viewModel: HomeViewModel
    @State private var didFetchData = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            if viewModel.isLoading {
                LoadingView()
                    .zIndex(1)
            } else if let errorMsg = viewModel.errorMsg {
                ErrorView(errorMessage: errorMsg) {
                    viewModel.fetchSurveys()
                }
                .zIndex(2)
            } else {
                SurveyListView(surveys: viewModel.surveys)
                    .zIndex(3)
            }

            if !viewModel.isLoading {
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
    }

    private var logoutButton: some View {
        Button(action: {
            viewModel.logout()
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(R.image.userpic)
        }
        .frame(width: 36, height: 36)
        .contentShape(Circle())
        .padding(.top, 35)
        .padding(.trailing, 20)
    }
}

#Preview {
    HomeScreen(viewModel: DI.instance.resolve(HomeViewModel.self)!)
}
