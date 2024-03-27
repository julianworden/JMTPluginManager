//
//  PluginScanningView.swift
//  PluginManager
//
//  Created by Julian Worden on 3/21/24.
//

import SwiftUI

struct PluginScanningView: View {
    @StateObject private var viewModel: PluginScanningViewModel
    
    let currentUser: User
    
    init(
        currentUser: User,
        databaseService: DatabaseServiceProtocol,
        authService: AuthServiceProtocol
    ) {
        self.currentUser = currentUser
        _viewModel = StateObject(
            wrappedValue: PluginScanningViewModel(
                currentUser: currentUser,
                databaseService: databaseService,
                authService: authService
            )
        )
    }
    
    var body: some View {
        switch viewModel.viewState {
        case .displayingStartPluginScanView,
             .scanningPlugins,
             .error(_):
            StartPluginScanView(viewModel: viewModel)
        case .displayingRecognizedPluginsView:
            RecognizedPluginsView(viewModel: viewModel)
        }
    }
}

#Preview {
    PluginScanningView(
        currentUser: User.example,
        databaseService: DatabaseService(),
        authService: AuthService()
    )
}
