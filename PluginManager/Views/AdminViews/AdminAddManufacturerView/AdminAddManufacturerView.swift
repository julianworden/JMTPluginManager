//
//  AdminAddManufacturerView.swift
//  PluginManager
//
//  Created by Julian Worden on 3/27/24.
//

import SwiftUI

struct AdminAddManufacturerView: View {
    @StateObject var viewModel: AdminAddManufacturerViewModel
    
    init(databaseService: DatabaseServiceProtocol, authService: AuthServiceProtocol) {
        _viewModel = StateObject(
            wrappedValue: AdminAddManufacturerViewModel(
                databaseService: databaseService,
                authService: authService
            )
        )
    }
    
    var body: some View {
        Form {
            TextField("Manufacturer Key", text: $viewModel.manufacturerKey)
            
            TextField("Manufacturer Name", text: $viewModel.manufacturerName)
            
            TextField("Website", text: $viewModel.manufacturerWebsite)
            
            TextField("Support Email Address", text: $viewModel.manufacturerSupportEmailAddress)
            
            TextField("Support Website Link", text: $viewModel.manufacturerSupportWebsiteLink)
            
            Button("Create Manufacturer") {
                Task {
                    await viewModel.createManufacturer()
                }
            }
        }
        .padding(50)
        .basicErrorAlert(
            message: viewModel.errorAlertMessage,
            isPresented: $viewModel.errorAlertIsShowing
        )
    }
}

#Preview {
    AdminAddManufacturerView(
        databaseService: DatabaseService(),
        authService: AuthService()
    )
}
