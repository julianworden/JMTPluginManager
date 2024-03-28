//
//  Plugin.swift
//  PluginManager
//
//  Created by Julian Worden on 3/11/24.
//

struct Plugin: Codable {
    /// The name of the collection that stores plugins in Firestore
    static let collectionName = "plugins"
    
    /// The plugin's document ID.
    let id: String
    /// The name of the plugin, not including any file extensions.
    let name: String
    /// The plug-in manufacturer's key.
    let manufacturerKey: String
}
