//
//  OnboardingView.swift
//  PluginManager
//
//  Created by Julian Worden on 3/17/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel: OnboardingViewModel
    
    init(authService: AuthServiceProtocol) {
        _viewModel = StateObject(wrappedValue: OnboardingViewModel(authService: authService))
    }
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                Image(.computerScreen)
                    .resizable()
                    .frame(width: geo.size.width / 2, height: geo.size.height)
                    .scaledToFill()
                
                Group {
                    switch viewModel.mode {
                    case .login:
                        LoginView(viewModel: viewModel)
                    case .signup:
                        SignupView(viewModel: viewModel)
                    case .forgotPassword:
                        ForgotPasswordView(viewModel: viewModel)
                    }
                }
                .frame(width: geo.size.width / 2, height: geo.size.height)
            }
        }
        .ignoresSafeArea()
        .basicErrorAlert(
            message: viewModel.errorAlertMessage,
            isPresented: $viewModel.errorAlertIsShowing
        )
    }
}

#Preview {
    OnboardingView(authService: AuthService())
}
