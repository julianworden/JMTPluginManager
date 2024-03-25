//
//  ForgotPasswordView.swift
//  PluginManager
//
//  Created by Julian Worden on 3/16/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Text("Forgot Password")
                .textFieldCaption()
            
            VStack(alignment: .leading) {
                TextField("Email Address", text: $viewModel.loginEmailAddress)
                    .textFieldStyle(MainTextFieldStyle())
                
                Text("If an account with your email address exists, we will send you a link to reset your password.")
                    .font(.caption)
                    .foregroundStyle(Color.secondary)
            }
        }
    }
}

#Preview {
    ForgotPasswordView(
        viewModel: OnboardingViewModel(
            authService: AuthService(),
            databaseService: DatabaseService()
        )
    )
}
