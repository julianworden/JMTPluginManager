//
//  ErrorMessageConstants.swift
//  PluginManager
//
//  Created by Julian Worden on 3/16/24.
//

import Foundation

struct ErrorMessageConstants {
    static let checkYourConnection = "Please confirm you have an internet connection."
    
    static let networkErrorOnLogIn = "Login failed. \(checkYourConnection)"
    static let wrongPasswordOnLogIn = "Incorrect email or password. Please try again."
    static let userNotFoundOnLogIn = "This email address is not registered with JMT Plugin Manager. If you need to create a new account, use the Sign Up button."
    static let unverifiedEmailAddressOnLogIn = "You cannot sign in until you verify your email address with JMT Plugin Manager."
    
    static let invalidPasswordOnSignUp = "Invalid password. Please enter a valid password that satisfies all the listed criteria."
    static let passwordsDoNotMatchOnSignUp = "The passwords you entered do not match. Please try again."
    static let passwordsDoNotMatch = "The passwords you entered do not match each other. Please try again."
    static let invalidEmailAddress = "Please enter a valid email address."
    static let emailAlreadyInUseOnSignUp = "An account with this email address already exists, please go back and sign in or reset your password, if necessary."
    static let networkErrorOnSignUp = "Sign up failed. \(checkYourConnection)"
    static let emailAddressesDoNotMatch = "The email addresses you entered do not match each other. Please try again."
    
    static let unknownError = "An unknown error occurred, please try again."
}
