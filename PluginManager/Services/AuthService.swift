//
//  AuthService.swift
//  PluginManager
//
//  Created by Julian Worden on 3/16/24.
//

import FirebaseAuth

final class AuthService: AuthServiceProtocol {
    func signUp(withEmail emailAddress: String, andPassword password: String) async throws {
        try await Auth.auth().createUser(withEmail: emailAddress, password: password)
        // TODO: Handle Error
    }
    
    func logIn(withEmail emailAddress: String, andPassword password: String) async throws {
        try await Auth.auth().signIn(withEmail: emailAddress, password: password)
        // TODO: HANDLE ERROR
    }
    
    func logOut() throws {
        try Auth.auth().signOut()
    }
}
