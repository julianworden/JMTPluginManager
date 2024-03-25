//
//  Constants.swift
//  PluginManager
//
//  Created by Julian Worden on 3/24/24.
//

import Foundation

enum Constants {
    enum UI {
        static let largeButtonMinWidth: CGFloat = 300
        static let largeButtonMinHeight: CGFloat = 41
    }
    
    enum URLs {
        static let defaultVSTLocation = URL(string: "file:///Library/Audio/Plug-Ins/VST")!
        static let defaultVST3Location = URL(string: "file:///Library/Audio/Plug-Ins/VST3")!
        static let defaultAULocation = URL(string: "file:///Library/Audio/Plug-Ins/Components")!
        static let defaultAAXLocation = URL(string: "file:///Library/Application Support/Avid/Audio/Plug-Ins")!
    }
    
    /// Represents the file extensions for each supported plugin format.
    enum PluginFileExtensions {
        static let vst = "vst"
        static let vst3 = "vst3"
        static let au = "component"
        static let aax = "aaxplugin"
    }
}
