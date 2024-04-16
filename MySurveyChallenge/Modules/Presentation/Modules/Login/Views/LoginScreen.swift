//
//  LoginScreen.swift
//  MySurveyChallenge
//
//  Created by Nguyen Truong Luu on 4/14/24.
//

import Combine
import SwiftUI

struct LoginScreen: View {
    enum Constants {
        static let animationStyle: Animation = .easeIn(duration: 0.5)
        static let buttonHeight = CGFloat(56)
        static let credentialsViewHeight = CGFloat(208)
        static let logoHeight = CGFloat(48)
        static let smallLogoScale = CGFloat(0.83)
    }

    enum Field {
        case email
        case password
    }

    @StateObject var viewModel: LoginViewModel
    @FocusState private var focusedField: Field?
    @State private var isFirstTimeAppear = true
    @State private var isAnimationCompleted = false
    @State private var logoScale: CGFloat = 1
    @State private var credentialsViewOpacity: CGFloat = 0
    @State private var logoOffset: CGFloat = {
        let screenHeight = UIScreen.size.height
        let space = ((screenHeight - Constants.credentialsViewHeight) / 2 - Constants.logoHeight) / 2
        return (Constants.credentialsViewHeight + Constants.logoHeight) / 2 + space
    }()

    private var space: CGFloat {
        let screenHeight = UIScreen.size.height
        return ((screenHeight - Constants.credentialsViewHeight) / 2 - Constants.logoHeight) / 2
    }

    var body: some View {
        VStack {
            Spacer()
                .frame(maxHeight: space)

            logoView

            Spacer()
                .frame(maxHeight: space)

            credentialsView

            Spacer()

            navigationLink
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding([.horizontal], 24)
        .edgesIgnoringSafeArea(.top)
        .background(backgroundView)
        .background(Color(R.color.colorDefaultBackgroundDark))
        .onTapGesture {
            endEditing()
        }
        .onSubmit {
            switch focusedField {
            case .email:
                focusedField = .password
            default:
                login()
            }
        }
        .onAppear {
            checkAuthenticationStatus()
        }
    }

    private func checkAuthenticationStatus() {
        if isFirstTimeAppear {
            isFirstTimeAppear = false
            Task {
                let isAuthenticated = await viewModel.checkAuthentication()
                if !isAuthenticated {
                    animate()
                }
            }
            return
        }

        if !isAnimationCompleted {
            animate()
        }
    }

    @MainActor
    private func animate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            logoOffset = 0
            credentialsViewOpacity = 1
            logoScale = Constants.smallLogoScale
            isAnimationCompleted = true
        }
    }

    private var backgroundView: some View {
        GeometryReader { geo in
            Image(isAnimationCompleted ? R.image.splashBlur : R.image.splash)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geo.size.width, height: geo.size.height)
                .animation(Constants.animationStyle, value: isAnimationCompleted)
        }
        .edgesIgnoringSafeArea(.all)
    }

    private var logoView: some View {
        Image(R.image.logoWhite)
            .scaleEffect(x: logoScale, y: logoScale)
            .animation(Constants.animationStyle, value: logoScale)
            .offset(y: logoOffset)
            .animation(Constants.animationStyle, value: logoOffset)
    }

    private var credentialsView: some View {
        VStack(alignment: .leading, spacing: 20) {
            emailField
            passwordField
            if let error = viewModel.loginErrorMsg {
                errorText(error)
            }
            loginButton
        }
        .opacity(credentialsViewOpacity)
        .animation(Constants.animationStyle, value: credentialsViewOpacity)
    }

    private func errorText(_ error: String) -> some View {
        Text(error)
            .font(Font(R.font.neuzeitSLTStdBook(size: 17)!))
            .foregroundColor(.red)
            .fixedSize(horizontal: false, vertical: true)
    }

    private var emailField: some View {
        TextField("Email",
                  text: $viewModel.username,
                  prompt: Text("Email")
                      .font(Font(R.font.neuzeitSLTStdBook(size: 17)!))
                      .foregroundColor(Color(R.color.colorDefaultPlaceholder)))
            .keyboardType(.emailAddress)
            .inputField()
            .focused($focusedField, equals: .email)
            .submitLabel(.next)
            .onTapGesture {
                focusedField = .email
            }
    }

    private var passwordField: some View {
        HStack {
            SecureField("Password",
                        text: $viewModel.password,
                        prompt: Text("Password")
                            .font(Font(R.font.neuzeitSLTStdBook(size: 17)!))
                            .foregroundColor(Color(R.color.colorDefaultPlaceholder)))
                .padding([.trailing], 70)
                .inputField()
                .focused($focusedField, equals: .password)
                .textContentType(.password)
                .submitLabel(.send)
                .onTapGesture {
                    focusedField = .password
                }
        }
        .overlay(alignment: .trailing) {
            forgotPasswordButton
        }
    }

    private var forgotPasswordButton: some View {
        Button(action: {}) {
            Text("Forgot?")
                .font(Font(R.font.neuzeitSLTStdBook(size: 17)!))
                .foregroundColor(Color(R.color.colorDefaultPlaceholder))
                .frame(maxHeight: .infinity)
                .padding(.horizontal, 12)
        }
    }

    private var loginButton: some View {
        Button(action: {
            login()
        }) {
            loginButtonContent
                .frame(maxWidth: .infinity)
                .frame(height: Constants.buttonHeight)
                .foregroundStyle(Color(R.color.colorDefaultOnSurface))
                .background(Color(R.color.colorDefaultBackground))
                .cornerRadius(10)
        }
        .disabled(!viewModel.loginButtonEnabled)
    }

    private func login() {
        endEditing()
        viewModel.login()
    }

    @ViewBuilder
    private var loginButtonContent: some View {
        if viewModel.isLoggingIn {
            ProgressView()
        } else {
            Text("Log in")
                .foregroundColor(Color(R.color.colorDefaultOnSurface))
                .font(Font(R.font.neuzeitSLTStdBookHeavy(size: 17)!))
        }
    }

    private var navigationLink: some View {
        NavigationLink(
            destination: HomeScreen(viewModel: DI.instance.resolve(HomeViewModel.self)!)
                .navigationBarHidden(true),
            isActive: $viewModel.loggedIn,
            label: {
                EmptyView()
            }
        )
        .hidden()
    }
}

#Preview {
    NavigationView {
        LoginScreen(viewModel: DI.instance.resolve(LoginViewModel.self)!)
    }
}
