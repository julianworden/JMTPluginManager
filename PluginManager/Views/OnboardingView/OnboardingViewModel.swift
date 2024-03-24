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
    
    enum ViewState {
        case displayingVew, userIsSignedIn(user: User), error(message: String)
    }
    
    @Published var mode = OnboardingViewMode.login
    @Published var viewState = ViewState.displayingVew {
        didSet {
            switch viewState {
            case .error(let message):
                errorAlertMessage = message
                errorAlertIsShowing = true
            default:
                break
            }
        }
    }
    @Published var forgotPasswordViewIsShowing = false
    
    // SignupView TextFields
    @Published var loginEmailAddress = ""
    @Published var loginPassword = ""
    @Published var signupEmailAddress = "" {
        didSet {
            checkIfSignupEmailsMatch()
        }
    }
    @Published var signupConfirmEmailAddress = "" {
        didSet {
            checkIfSignupEmailsMatch()
        }
    }
    @Published var signupEmailsMatch = false
    @Published var signupPassword = "" {
        didSet {
            checkIfSignupPasswordIsValid()
            checkIfSignupPasswordsMatch()
        }
    }
    @Published var signupConfirmPassword = "" {
        didSet {
            checkIfSignupPasswordsMatch()
        }
    }
    @Published var signupPasswordIsLongEnough = false
    @Published var signupPasswordContainsSpecialCharacter = false
    @Published var signupPasswordContainsUpperAndLowercase = false
    @Published var signupPasswordsMatch = false
    
    @Published var errorAlertIsShowing = false
    var errorAlertMessage = ""
    
    var signupPasswordIsValid: Bool {
        return signupPasswordIsLongEnough &&
        signupPasswordContainsSpecialCharacter &&
        signupPasswordContainsUpperAndLowercase
    }
    
    let authService: AuthServiceProtocol
    let databaseService: DatabaseServiceProtocol
    
    init(
        authService: AuthServiceProtocol,
        databaseService: DatabaseServiceProtocol
    ) {
        self.authService = authService
        self.databaseService = databaseService
    }
    
    func createAccount() async {
        do {
            guard signupPasswordIsValid else {
                viewState = .error(message: ErrorMessageConstants.invalidPasswordOnSignUp)
                return
            }
            
            guard signupPasswordsMatch else {
                viewState = .error(message: ErrorMessageConstants.passwordsDoNotMatch)
                return
            }
            
            guard signupEmailsMatch else {
                viewState = .error(message: ErrorMessageConstants.emailAddressesDoNotMatch)
                return
            }
            
            let signupResult = try await authService.signUp(withEmail: signupEmailAddress, andPassword: signupPassword)
            let newUser = User(uid: signupResult.user.uid, emailAddress: signupEmailAddress)
            
            try databaseService.createUser(newUser)
        } catch {
            let error = AuthErrorCode(_nsError: error as NSError)
            
            switch error.code {
            case .invalidEmail, .missingEmail:
                viewState = .error(message: ErrorMessageConstants.invalidEmailAddress)
            case .emailAlreadyInUse:
                viewState = .error(message: ErrorMessageConstants.emailAlreadyInUseOnSignUp)
            case .networkError:
                viewState = .error(message: "\(ErrorMessageConstants.networkErrorOnSignUp). System error: \(error.localizedDescription)")
            case .weakPassword:
                viewState = .error(message: ErrorMessageConstants.invalidPasswordOnSignUp)
                print("ERROR: \("❌ \(error)")")
            default:
                viewState = .error(message: "\(ErrorMessageConstants.unknownError). System error: \(error.localizedDescription)")
            }
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
                viewState = .error(message: "\(ErrorMessageConstants.networkErrorOnLogIn). System error: \(error.localizedDescription)")
            case .wrongPassword:
                viewState = .error(message: ErrorMessageConstants.wrongPasswordOnLogIn)
            case .userNotFound:
                // Password and email are valid, but no registered user has this info
                viewState = .error(message: ErrorMessageConstants.userNotFoundOnLogIn)
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
    
    func checkIfSignupEmailsMatch() {
        guard !signupConfirmEmailAddress.isEmpty else {
            signupEmailsMatch = false
            return
        }
        
        signupEmailsMatch = (signupEmailAddress == signupConfirmEmailAddress)
    }
    
    func checkIfSignupPasswordIsValid() {
        signupPasswordIsLongEnough = (signupPassword.count >= 6)
        signupPasswordContainsSpecialCharacter = signupPassword.containsSpecialCharacter
        signupPasswordContainsUpperAndLowercase = signupPassword.containsUpperAndLowercaseCharacters
    }
    
    func checkIfSignupPasswordsMatch() {
        guard !signupConfirmPassword.isEmpty else {
            signupPasswordsMatch = false
            return
        }
        
        signupPasswordsMatch = (signupPassword == signupConfirmPassword)
    }
}
