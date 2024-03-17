//
//  AuthServiceProtocol.swift
//  PluginManager
//
//  Created by Julian Worden on 3/16/24.
//

import Foundation

protocol AuthServiceProtocol {
    func signUp(withEmail emailAddress: String, andPassword password: String) async throws
    func logIn(withEmail emailAddress: String, andPassword password: String) async throws
    func logOut() throws
}
