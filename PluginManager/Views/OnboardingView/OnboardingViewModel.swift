//
//  OnboardingViewModel.swift
//  PluginManager
//
//  Created by Julian Worden on 3/17/24.
//

import FirebaseAuth

@MainActor
final class OnboardingViewModel: ObservableObject {
    enum OnboardingViewMode {
        case login, signup, forgotPassword
    }
    
    enum LoginViewState {
        case displayingVew, error(message: String)
    }
    
    @Published var mode = OnboardingViewMode.login
    @Published var viewState = LoginViewState.displayingVew
    @Published var forgotPasswordViewIsShowing = false
    
    @Published var loginEmailAddress = ""
    @Published var loginPassword = ""
    
    let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func createAccount() async {
        do {
            try await authService.signUp(withEmail: loginEmailAddress, andPassword: loginPassword)
        } catch {
            print("❌ Error creating account: \(error)")
        }
    }
    
    func logIn() async {
        do {
            try await authService.logIn(withEmail: loginEmailAddress, andPassword: loginPassword)
        } catch {
            let error = AuthErrorCode(_nsError: error as NSError)
            
            switch error.code {
            case .invalidEmail:
                viewState = .error(message: ErrorMessageConstants.invalidEmailAddress)
            case .networkError:
                viewState = .error(message: "\(ErrorMessageConstants.networkErrorOnSignIn). System error: \(error.localizedDescription)")
            case .wrongPassword:
                viewState = .error(message: ErrorMessageConstants.wrongPasswordOnSignIn)
            case .userNotFound:
                // Password and email are valid, but no registered user has this info
                viewState = .error(message: ErrorMessageConstants.userNotFoundOnSignIn)
            default:
                viewState = .error(message: "\(ErrorMessageConstants.unknownError). System error: \(error.localizedDescription)")
            }
        }
    }
    
    func logOut() async {
        do {
            try authService.logOut()
        } catch {
            print("❌ Error logging out: \(error)")
        }
    }
}
