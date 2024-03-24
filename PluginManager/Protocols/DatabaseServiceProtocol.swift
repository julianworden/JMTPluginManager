//
//  DatabaseServiceProtocol.swift
//  PluginManager
//
//  Created by Julian Worden on 3/21/24.
//

protocol DatabaseServiceProtocol {
    func createUser(_ user: User) throws
    func getUser(withUID uid: String) async throws -> User
}
