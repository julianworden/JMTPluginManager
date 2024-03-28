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
                ProgressView()
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
                
            case .addPluginsToDatabase:
                AdminAddPluginsView(
                    databaseService: viewModel.databaseService,
                    authService: viewModel.authService
                )
                
            case .addManufacturerToDatabase:
                AdminAddManufacturerView(
                    databaseService: viewModel.databaseService,
                    authService: viewModel.authService
                )
            }
        }
        .toolbar {
            ToolbarItemGroup {
                Button("LOG OUT") { try! viewModel.authService.logOut() }
                
                if let currentUser = viewModel.authService.getCurrentUser(),
                   let currentUserEmail = currentUser.email,
                   // TODO: Don't hard code this
                   currentUserEmail == "julianworden@gmail.com" {
                    Button("ADD PLUG-INS") { viewModel.viewState = .addPluginsToDatabase }
                    Button("ADD MANUFACTURER") { viewModel.viewState = .addManufacturerToDatabase }
                }
            }
        }
        .task {
            await viewModel.determineIfUserIsSignedIn()
        }
    }
    

}

#Preview {
    AppViewContainer()
}
