//
//  DatabaseServiceProtocol.swift
//  PluginManager
//
//  Created by Julian Worden on 3/21/24.
//

protocol DatabaseServiceProtocol {
    func createUser(_ user: User) throws
    func getUser(withUID uid: String) async throws -> User
    func createInstalledPlugin(
        _ installedPlugin: InstalledPlugin,
        forUser user: User
    ) async throws -> InstalledPlugin
    func getInstalledPlugin(
        withName pluginName: String,
        forUser user: User
    ) async throws -> InstalledPlugin?
    func updateInstalledPlugin(
        _ installedPlugin: InstalledPlugin,
        withNewFormat newFormat: String,
        forUser user: User
    ) async throws
}
