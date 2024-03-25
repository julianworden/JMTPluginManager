//
//  PluginScanningViewModel.swift
//  PluginManager
//
//  Created by Julian Worden on 3/24/24.
//

import Foundation

@MainActor
final class PluginScanningViewModel: ObservableObject {
    let databaseService: DatabaseServiceProtocol
    let authService: AuthServiceProtocol
    
    init(databaseService: DatabaseServiceProtocol, authService: AuthServiceProtocol) {
        self.databaseService = databaseService
        self.authService = authService
    }
}
