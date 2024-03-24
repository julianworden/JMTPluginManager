//
//  AuthService.swift
//  PluginManager
//
//  Created by Julian Worden on 3/16/24.
//

import FirebaseAuth

final class AuthService: AuthServiceProtocol {
    let auth = Auth.auth()
    
    func signUp(withEmail emailAddress: String, andPassword password: String) async throws -> AuthDataResult {
        let result = try await auth.createUser(withEmail: emailAddress, password: password)
        return result
        // TODO: Handle Error
    }
    
    func logIn(withEmail emailAddress: String, andPassword password: String) async throws {
        try await auth.signIn(withEmail: emailAddress, password: password)
        // TODO: HANDLE ERROR
    }
    
    func logOut() throws {
        try auth.signOut()
    }
    
    func getCurrentUser() -> FirebaseAuth.User? {
        return auth.currentUser
    }
}
