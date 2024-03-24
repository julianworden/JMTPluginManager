//
//  PluginManagerApp.swift
//  PluginManager
//
//  Created by Julian Worden on 3/11/24.
//

import FirebaseCore
import SwiftUI


@main
struct PluginManagerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AppViewContainer()
        }
        .windowStyle(.hiddenTitleBar)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        
    }
}
