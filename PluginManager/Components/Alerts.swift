//
//  Alerts.swift
//  PluginManager
//
//  Created by Julian Worden on 3/17/24.
//

import SwiftUI

extension View {
    func basicErrorAlert(message: String, isPresented: Binding<Bool>) -> some View {
        return self
            .alert(
                "Error",
                isPresented: isPresented,
                actions: { Button("OK") { }},
                message: { Text(message) }
            )
    }
}
