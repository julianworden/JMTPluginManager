//
//  AppViewContainer.swift
//  PluginManager
//
//  Created by Julian Worden on 3/21/24.
//

import SwiftUI

struct AppViewContainer: View {
    @StateObject private var viewModel: AppViewContainerViewModel
    
    init() {
        _viewModel = StateObject(
            wrappedValue: AppViewContainerViewModel(
                databaseService: DatabaseService(),
                authService: AuthService()
            )
        )
    }
    
    var body: some View {
        Group {
            switch viewModel.viewState {
            case .determiningIfUserIsSignedIn:
                OnboardingView(
                    authService: viewModel.authService,
                    databaseService: viewModel.databaseService
                )
            case .userIsSignedIn(let currentUser):
                PluginScanningView(
                    currentUser: currentUser,
                    databaseService: viewModel.databaseService,
                    authService: viewModel.authService
                )
            case .userIsNotSignedIn:
                OnboardingView(
                    authService: viewModel.authService,
                    databaseService: viewModel.databaseService
                )
            }
        }
        .toolbar {
            Button("LOG OUT") { try! viewModel.authService.logOut() }
        }
        .task {
            await viewModel.determineIfUserIsSignedIn()
        }
    }
    

}

#Preview {
    AppViewContainer()
}
