//
//  RecognizedPluginsView.swift
//  PluginManager
//
//  Created by Julian Worden on 3/25/24.
//

import SwiftUI

struct RecognizedPluginsView: View {
    @ObservedObject var viewModel: PluginScanningViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Scan Complete")
                .pageTitle()
            
            Text(
                "We’ve cross referenced the plugins installed on your computer with the plugins stored in our database. We found 549 plugins that we recognize, they are all listed below:"
            )
        }
        .padding(50)
    }
}

#Preview {
    RecognizedPluginsView(
        viewModel: PluginScanningViewModel(
            currentUser: User.example,
            databaseService: DatabaseService(),
            authService: AuthService()
        )
    )
}
