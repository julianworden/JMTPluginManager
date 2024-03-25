//
//  InstalledPlugin.swift
//  PluginManager
//
//  Created by Julian Worden on 3/25/24.
//

struct InstalledPlugin: Codable {
    /// The name of the collection that stores installed plugins in Firestore
    static let collectionName = "installedPlugins"
    
    /// The plugin's document ID in the `installedPlugins` collection as
    /// well as the document ID of the plugin in the `plugins` collection.
    let id: String
    /// The name of the plugin, including the file extension.
    let name: String
    /// The version of the plugin that is installed on the user's computer.
    let installedVersion: String
    /// The formats that the user has installed on their computer. For example,
    /// if the user has installed the VST and VST3 formats, this array would
    /// read ["VST", "VST3"].
    let installedFormats: [String]
}
