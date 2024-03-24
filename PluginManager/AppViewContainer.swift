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
            case .userIsSignedIn(let user):
                VStack {
                    Text("Hello \(user.emailAddress) and \(user.uid)!!!")
                    Button("LOG OUT") {
                        try! viewModel.authService.logOut()
                    }
                }
            case .userIsNotSignedIn:
                OnboardingView(authService: viewModel.authService, databaseService: viewModel.databaseService)
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
