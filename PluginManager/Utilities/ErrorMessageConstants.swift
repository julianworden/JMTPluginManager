//
//  ErrorMessageConstants.swift
//  PluginManager
//
//  Created by Julian Worden on 3/16/24.
//

import Foundation

struct ErrorMessageConstants {
    static let checkYourConnection = "Please confirm you have an internet connection."
    
    static let networkErrorOnSignIn = "Login failed. \(checkYourConnection)"
    static let wrongPasswordOnSignIn = "Incorrect email or password. Please try again."
    static let userNotFoundOnSignIn = "This email address is not registered with The Same Page. If you need to create a new account, use the Sign Up button."
    static let unverifiedEmailAddressOnSignIn = "You cannot sign in until you verify your email address with The Same Page."
    
    static let invalidEmailAddress = "Please enter a valid email address."
    
    static let unknownError = "An unknown error occurred, please try again."
}
