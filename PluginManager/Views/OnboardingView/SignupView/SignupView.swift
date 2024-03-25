//
//  SignupView.swift
//  PluginManager
//
//  Created by Julian Worden on 3/16/24.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Sign Up")
                .pageTitle()
            
            VStack(alignment: .leading) {
                TextField("Email Address", text: $viewModel.signupEmailAddress)
                    .textFieldStyle(MainTextFieldStyle())
                
                Text("We will send a verification email to this email address")
                    .textFieldCaption()
                
                TextField("Confirm Email Address", text: $viewModel.signupConfirmEmailAddress)
                    .textFieldStyle(MainTextFieldStyle())
                
                TextFieldStatusView(
                    inputIsValid: $viewModel.signupEmailsMatch,
                    validMessage: "Email addresses match.",
                    invalidMessage: "Email addresses do not match."
                )
                
                SecureField("Password", text: $viewModel.signupPassword)
                    .textFieldStyle(MainTextFieldStyle())
                
                TextFieldStatusView(
                    inputIsValid: $viewModel.signupPasswordIsLongEnough,
                    validMessage: "Includes at least 6 characters.",
                    invalidMessage: "Does not include at least 6 characters."
                )
                
                TextFieldStatusView(
                    inputIsValid: $viewModel.signupPasswordContainsSpecialCharacter,
                    validMessage: "Includes at least 1 special character (!, @, #, etc.)",
                    invalidMessage: "Does not include at least 1 special character (!, @, #, etc.)"
                )
                
                TextFieldStatusView(
                    inputIsValid: $viewModel.signupPasswordContainsUpperAndLowercase,
                    validMessage: "Includes uppercase and lowercase letters.",
                    invalidMessage: "Does not include uppercase and lowercase letters."
                )
                
                SecureField("Confirm Password", text: $viewModel.signupConfirmPassword)
                    .textFieldStyle(MainTextFieldStyle())
                
                TextFieldStatusView(
                    inputIsValid: $viewModel.signupPasswordsMatch,
                    validMessage: "Passwords match.",
                    invalidMessage: "Passwords do not match."
                )
            }
            
            Button {
                Task {
                    await viewModel.createAccount()
                }
            } label: {
                Text("Sign Up")
                    .frame(maxWidth: .infinity, minHeight: Constants.UI.largeButtonMinHeight)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(50)
    }
}

#Preview {
    SignupView(
        viewModel: OnboardingViewModel(
            authService: AuthService(),
            databaseService: DatabaseService()
        )
    )
}
