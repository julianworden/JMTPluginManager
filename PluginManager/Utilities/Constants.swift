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
    
    enum FirestoreFields {
        static let id = "id"
        static let name = "name"
        static let installedFormats = "installedFormats"
    }
    
    enum PluginPlistProperties {
        static let bundleShortVersionString = "CFBundleShortVersionString"
    }
    
    enum PluginPackageContents {
        static let contents = "Contents"
        static let infoPlist = "Info.plist"
    }
}
