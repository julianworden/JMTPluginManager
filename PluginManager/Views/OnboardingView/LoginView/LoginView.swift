//
//  LoginView.swift
//  PluginManager
//
//  Created by Julian Worden on 3/11/24.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Log In")
                .font(.largeTitle.bold())
            
            VStack(alignment: .trailing, spacing: 10) {
                TextField("Email Address", text: $viewModel.loginEmailAddress)
                    .textFieldStyle(MainTextFieldStyle())
                
                SecureField("Password", text: $viewModel.loginPassword)
                    .textFieldStyle(MainTextFieldStyle())
                
                Button {
                    viewModel.mode = .forgotPassword
                } label: {
                    Text("Forgot Password?")
                        .underline()
                }
                .buttonStyle(.plain)
                
                Button {
                    Task {
                        await viewModel.logIn()
                    }
                } label: {
                    Text("Log In")
                }
                .buttonStyle(PrimaryButtonStyle())
                
                Button {
                    viewModel.mode = .signup
                } label: {
                    Text("Sign Up")
                        .underline()
                }
                .buttonStyle(.plain)
            }
        }
        .padding(50)
    }
}

#Preview {
    LoginView(viewModel: OnboardingViewModel(authService: AuthService()))
        .ignoresSafeArea()
        .frame(width: 870, height: 580)
}