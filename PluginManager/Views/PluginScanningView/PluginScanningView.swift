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
                databaseService: databaseService,
                authService: authService
            )
        )
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Scan Your Plugins")
                .pageTitle()
            
            Text(
                 """
                 In order to get started, we’ll need to scan your computer’s file system to see what plug-ins you have installed.

                 By default, we will scan the plug-in files at the following locations on your computer, but if you have installed plugin files in any custom locations you can select those locations below:

                 • VST: /Library/Audio/Plug-Ins/VST

                 • VST3: /Library/Audio/Plug-Ins/VST3
                 
                 • AU: /Library/Audio/Plug-Ins/Components

                 • AAX: /Library/Application Support/Avid/Audio/Plug-Ins

                 • Custom: /Users/julianworden/Desktop/Plugins
                 """
            )
            
            Button {
                
            } label: {
                Text("Start Scan")
                    .frame(
                        minWidth: Constants.UI.largeButtonMinWidth,
                        minHeight: Constants.UI.largeButtonMinHeight
                    )
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                // TODO: Select Custom Location
            } label: {
                Text("Select Custom Location")
                    .frame(
                        minWidth: Constants.UI.largeButtonMinWidth,
                        minHeight: Constants.UI.largeButtonMinHeight
                    )
            }
            
            Button("LOG OUT") {
                try! viewModel.authService.logOut()
            }
            
        }
        .padding(50)
    }
}

#Preview {
    PluginScanningView(
        currentUser: User.example,
        databaseService: DatabaseService(),
        authService: AuthService()
    )
}
