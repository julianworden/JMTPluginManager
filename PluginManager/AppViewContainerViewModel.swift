//
//  AppViewContainerViewModel.swift
//  PluginManager
//
//  Created by Julian Worden on 3/21/24.
//

import Foundation

@MainActor
final class AppViewContainerViewModel: ObservableObject {
    enum ViewState {
        case determiningIfUserIsSignedIn, userIsSignedIn(user: User), userIsNotSignedIn
    }
    
    @Published var viewState = ViewState.determiningIfUserIsSignedIn
    
    let databaseService: DatabaseServiceProtocol
    let authService: AuthServiceProtocol
    
    init(databaseService: DatabaseServiceProtocol, authService: AuthServiceProtocol) {
        self.databaseService = databaseService
        self.authService = authService
    }
    
    func determineIfUserIsSignedIn() async {
        Task {
            if let currentAuthUser = authService.getCurrentUser() {
                let currentUser = try await databaseService.getUser(withUID: currentAuthUser.uid)
                
                viewState = .userIsSignedIn(user: currentUser)
            } else {
                viewState = .userIsNotSignedIn
            }
        }
    }
}
