//
//  InitialPluginScanningView.swift
//  PluginManager
//
//  Created by Julian Worden on 3/21/24.
//

import SwiftUI

struct InitialPluginScanningView: View {
    let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    InitialPluginScanningView(currentUser: User.example)
}
