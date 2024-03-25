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
        case displayingView
        case scanningVSTPlugins
        case scanningVST3Plugins
        case scanningAUPlugins
        case scanningAAXPlugins
        case error(message: String)
    }
    
    @Published var viewState = ViewState.displayingView
    
    @Published var scannedVSTPluginNames = [String]()
    @Published var vstPluginsHaveBeenScanned = false
    @Published var vst3PluginsHaveBeenScanned = false
    @Published var auPluginsHaveBeenScanned = false
    @Published var aaxPluginsHaveBeenScanned = false
    @Published var scannedCustomPluginPaths = false
    
    let databaseService: DatabaseServiceProtocol
    let authService: AuthServiceProtocol
    
    init(databaseService: DatabaseServiceProtocol, authService: AuthServiceProtocol) {
        self.databaseService = databaseService
        self.authService = authService
    }
    
    func beginPluginScan() {
        scanVSTPlugins()
    }
    
    private func scanVSTPlugins() {
        viewState = .scanningVSTPlugins
        
        var scannedVSTPlugins = [String]()
        
        let vstDirectory = Constants.URLs.defaultVSTLocation
        
        do {
            let vstDirectoryContentURLs = try FileManager.default.contentsOfDirectory(
                at: vstDirectory,
                includingPropertiesForKeys: nil
            )
            
            for vstDirectoryContentURL in vstDirectoryContentURLs {
                if vstDirectoryContentURL.pathExtension == Constants.PluginFileExtensions.vst {
                    // Found a VST plugin
                    scannedVSTPlugins.append(vstDirectoryContentURL.lastPathComponent)
                    continue
                } else {
                    let subFolderContents = try FileManager.default.contentsOfDirectory(at: vstDirectoryContentURL, includingPropertiesForKeys: nil)
                    
                    for subfolderContent in subFolderContents {
                        if subfolderContent.pathExtension == Constants.PluginFileExtensions.vst {
                            // Found a VST plugin
                            scannedVSTPlugins.append(subfolderContent.lastPathComponent)
                            continue
                        }
                    }
                }
            }
        } catch {
            viewState = .error(
                message: "\(FileManagerError.failedToInspectDirectoryContents.localizedDescription) System Error: \(error.localizedDescription)"
            )
        }
        
        self.scannedVSTPluginNames = scannedVSTPlugins
    }
}
