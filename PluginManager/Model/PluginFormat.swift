//
//  PluginFormat.swift
//  PluginManager
//
//  Created by Julian Worden on 3/27/24.
//

import Foundation

enum PluginFormat: CaseIterable {
    case vst
    case vst3
    case au
    case aax
    
    var fileExtension: String {
        switch self {
        case .vst:
            return "vst"
        case .vst3:
            return "vst3"
        case .au:
            return "component"
        case .aax:
            return "aaxplugin"
        }
    }
    
    var defaultLocation: URL {
        switch self {
        case .vst:
            return URL(string: "file:///Library/Audio/Plug-Ins/VST")!
        case .vst3:
            return URL(string: "file:///Library/Audio/Plug-Ins/VST3")!
        case .au:
            return URL(string: "file:///Library/Audio/Plug-Ins/Components")!
        case .aax:
            return URL(string: "file:///Library/Application Support/Avid/Audio/Plug-Ins")!
        }
    }
}
