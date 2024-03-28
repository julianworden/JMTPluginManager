//
//  AdminAddPluginsView.swift
//  PluginManager
//
//  Created by Julian Worden on 3/27/24.
//

import SwiftUI

struct AdminAddPluginsView: View {
    @StateObject var viewModel: AdminAddPluginsViewModel
    
    init(databaseService: DatabaseServiceProtocol, authService: AuthServiceProtocol) {
        _viewModel = StateObject(
            wrappedValue: AdminAddPluginsViewModel(
                databaseService: databaseService,
                authService: authService
            )
        )
    }
    
    var body: some View {
        Form {
            Button {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = true
                panel.canChooseDirectories = true
                if panel.runModal() == .OK {
                    // TODO: Make this work
                    print(panel.urls[0])
                }
            } label: {
                Text("Select Custom Location")
                    .frame(
                        minWidth: Constants.UI.largeButtonMinWidth,
                        minHeight: Constants.UI.largeButtonMinHeight
                    )
            }
        }
        .padding(50)
    }
}

#Preview {
    AdminAddPluginsView(
        databaseService: DatabaseService(),
        authService: AuthService()
    )
}
