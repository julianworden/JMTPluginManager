//
//  PluginScanningView.swift
//  PluginManager
//
//  Created by Julian Worden on 3/21/24.
//

import SwiftUI

struct PluginScanningView: View {
    let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
    }
    
    var body: some View {
        Text("Scan Your Plugins")
            .pageTitle()
    }
}

#Preview {
    PluginScanningView(currentUser: User.example)
}
