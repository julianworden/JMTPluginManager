//
//  AdminAddManufacturerViewModel.swift
//  PluginManager
//
//  Created by Julian Worden on 3/27/24.
//

import Foundation

@MainActor final class AdminAddManufacturerViewModel: ObservableObject {
    enum ViewState {
        case displayingView
        case error(message: String)
    }
    
    @Published var viewState = ViewState.displayingView {
        didSet {
            switch viewState {
            case .error(let message):
                errorAlertMessage = message
                errorAlertIsShowing = true
            default:
                break
            }
        }
    }
    @Published var errorAlertIsShowing = false
    var errorAlertMessage = ""
    
    /// A 4-digit code that is unique to every plugin manufacturer.
    @Published var manufacturerKey = ""
    @Published var manufacturerName = ""
    /// The manufacturer's website, including "https://www."
    @Published var manufacturerWebsite = ""
    @Published var manufacturerSupportEmailAddress = ""
    @Published var manufacturerSupportWebsiteLink = ""
    
    let databaseService: DatabaseServiceProtocol
    let authService: AuthServiceProtocol
    
    init(
        databaseService: DatabaseServiceProtocol,
        authService: AuthServiceProtocol
    ) {
        self.databaseService = databaseService
        self.authService = authService
    }
    
    func createManufacturer() async {
        do {
            guard manufacturerKey.count == 4 else {
                viewState = .error(message: "The manufacturer key can only be 4 characters long.")
                return
            }
            
            guard !manufacturerName.isReallyEmpty else {
                viewState = .error(message: "A manufacturer name is required")
                return
            }
            
            guard !manufacturerSupportEmailAddress.isEmpty || !manufacturerSupportWebsiteLink.isEmpty else {
                viewState = .error(message: "Either a support email or support website link is required.")
                return
            }
            
            guard !manufacturerWebsite.isReallyEmpty else {
                viewState = .error(message: "A manufacturer website is required")
                return
            }
    
            let manufacturer = Manufacturer(
                id: "",
                key: manufacturerKey,
                name: manufacturerName,
                website: manufacturerWebsite,
                supportEmailAddress: manufacturerSupportEmailAddress.isReallyEmpty ? nil : manufacturerSupportEmailAddress,
                supportWebsiteLink: manufacturerSupportWebsiteLink.isReallyEmpty ? nil : manufacturerSupportWebsiteLink
            )
            
            try await databaseService.adminCreateManufacturer(manufacturer)
            
            clearTextFieldValues()
        } catch {
            viewState = .error(message: error.localizedDescription)
        }
    }
    
    private func clearTextFieldValues() {
        manufacturerKey = ""
        manufacturerName = ""
        manufacturerSupportEmailAddress = ""
        manufacturerSupportWebsiteLink = ""
        manufacturerWebsite = ""
    }
}
