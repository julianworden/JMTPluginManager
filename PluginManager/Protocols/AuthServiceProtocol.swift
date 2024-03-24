//
//  AuthServiceProtocol.swift
//  PluginManager
//
//  Created by Julian Worden on 3/16/24.
//

import FirebaseAuth

protocol AuthServiceProtocol {
    // MARK: - Modify Login State
    func signUp(withEmail emailAddress: String, andPassword password: String) async throws -> AuthDataResult
    func logIn(withEmail emailAddress: String, andPassword password: String) async throws
    func logOut() throws
    
    func getCurrentUser() -> FirebaseAuth.User?
}
