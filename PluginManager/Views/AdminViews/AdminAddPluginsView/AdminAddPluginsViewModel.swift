//
//  AdminAddPluginsViewModel.swift
//  PluginManager
//
//  Created by Julian Worden on 3/27/24.
//

import Foundation

@MainActor final class AdminAddPluginsViewModel: ObservableObject {
    let databaseService: DatabaseServiceProtocol
    let authService: AuthServiceProtocol
    
    init(
        databaseService: DatabaseServiceProtocol,
        authService: AuthServiceProtocol
    ) {
        self.databaseService = databaseService
        self.authService = authService
    }
}
