//
//  PluginScanningViewModel.swift
//  PluginManager
//
//  Created by Julian Worden on 3/24/24.
//

import Foundation

@MainActor
final class PluginScanningViewModel: ObservableObject {
    enum ViewState {
        case displayingStartPluginScanView
        case displayingRecognizedPluginsView
        case scanningPlugins
        case error(message: String)
    }
    
    @Published var viewState = ViewState.displayingStartPluginScanView
    @Published var scannedPluginURLs = [URL]()
    @Published var vstPluginsHaveBeenScanned = false
    @Published var vst3PluginsHaveBeenScanned = false
    @Published var auPluginsHaveBeenScanned = false
    @Published var aaxPluginsHaveBeenScanned = false
    @Published var scannedCustomPluginPaths = false
    
    var installedPlugins = [InstalledPlugin]()
    
    let currentUser: User
    let databaseService: DatabaseServiceProtocol
    let authService: AuthServiceProtocol
    
    init(currentUser: User, databaseService: DatabaseServiceProtocol, authService: AuthServiceProtocol) {
        self.currentUser = currentUser
        self.databaseService = databaseService
        self.authService = authService
    }
    
    func scanPlugins() async {
        getPluginURLs()
        await saveInstalledPluginData()
        
        viewState = .displayingRecognizedPluginsView
    }
    
    /// Get the name and URL for each VST plugin installed at the default VST location on the user's computer.
    private func getPluginURLs() {
        viewState = .scanningPlugins
                
        for pluginFormat in PluginFormat.allCases {
            do {
                let pluginDirectoryContentURLs = try FileManager.default.contentsOfDirectory(
                    at: pluginFormat.defaultLocation,
                    includingPropertiesForKeys: nil
                    //
                ).withoutHiddenFiles
                
                for pluginDirectoryContentURL in pluginDirectoryContentURLs {
                    if pluginDirectoryContentURL.pathExtension == pluginFormat.fileExtension {
                        // Found a plugin
                        scannedPluginURLs.append(pluginDirectoryContentURL)
                    } else {
                        let subFolderContents = try FileManager.default.contentsOfDirectory(
                            at: pluginDirectoryContentURL,
                            includingPropertiesForKeys: nil
                        ).withoutHiddenFiles
                        
                        for subfolderContent in subFolderContents {
                            if subfolderContent.pathExtension == pluginFormat.fileExtension {
                                // Found a VST plugin
                                scannedPluginURLs.append(subfolderContent)
                            }
                        }
                    }
                }
            } catch {
                viewState = .error(
                    message: "\(FileManagerError.failedToInspectDirectoryContents.localizedDescription) System Error: \(error.localizedDescription)"
                )
                break
            }
        }
    }
    
    private func saveInstalledPluginData() async {
        do {
            for scannedPluginURL in scannedPluginURLs {
                let plistURL = scannedPluginURL
                    .appendingPathComponent(Constants.PluginPackageContents.contents)
                    .appendingPathComponent(Constants.PluginPackageContents.infoPlist)
                
                let plistAsDictionary = try NSDictionary(
                    contentsOf: plistURL,
                    error: ()
                )
                
                let pluginName = scannedPluginURL.pluginName
                let pluginNameFileExtension = scannedPluginURL.lastPathComponent.pluginNameFileExtension
                
                if let installedPlugin = try await databaseService.getInstalledPlugin(
                    withName: pluginName,
                    forUser: currentUser
                ) {
                    // User has the InstalledPlugin, update the formats array to reflect they have another format installed
                    try await databaseService.updateInstalledPlugin(
                        installedPlugin,
                        withNewFormat: pluginNameFileExtension,
                        forUser: currentUser
                    )
                } else {
                    // User does not have the InstalledPlugin

                    let pluginVersion = plistAsDictionary[Constants.PluginPlistProperties.bundleShortVersionString] as! String
                    
                    let installedPlugin = InstalledPlugin(
                        id: "",
                        name: scannedPluginURL.pluginName,
                        installedVersion: pluginVersion,
                        installedFormats: [
                            pluginNameFileExtension
                        ]
                    )
                    
                    let installedPluginWithDocumentID = try await databaseService.createInstalledPlugin(installedPlugin, forUser: currentUser)
                    
                    installedPlugins.append(installedPluginWithDocumentID)
                }
            }
        } catch {
            viewState = .error(message: error.localizedDescription)
        }
    }
}
