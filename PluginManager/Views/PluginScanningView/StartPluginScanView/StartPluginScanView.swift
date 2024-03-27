//
//  StartPluginScanView.swift
//  PluginManager
//
//  Created by Julian Worden on 3/25/24.
//

import SwiftUI

struct StartPluginScanView: View {
    @ObservedObject var viewModel: PluginScanningViewModel
    
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
                Task {
                    await viewModel.scanPlugins()
                }
            } label: {
                Text("Start Scan")
                    .frame(
                        minWidth: Constants.UI.largeButtonMinWidth,
                        minHeight: Constants.UI.largeButtonMinHeight
                    )
            }
            .buttonStyle(.borderedProminent)
            
            Button {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = false
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
    StartPluginScanView(
        viewModel: PluginScanningViewModel(
            currentUser: User.example,
            databaseService: DatabaseService(),
            authService: AuthService()
        )
    )
}
