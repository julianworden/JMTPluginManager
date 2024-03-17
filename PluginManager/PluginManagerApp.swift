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
    
    let authService = AuthService()
    
    var body: some Scene {
        WindowGroup {
            OnboardingView(authService: authService)
        }
        .windowStyle(.hiddenTitleBar)
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        FirebaseApp.configure()
    }
}
