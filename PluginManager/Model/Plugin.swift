//
//  Plugin.swift
//  PluginManager
//
//  Created by Julian Worden on 3/11/24.
//

struct Plugin: Codable {
    /// The name of the collection that stores plugins in Firestore
    static let collectionName = "plugins"
    
    let id: String
    let name: String
    let vst3FileName: String?
    let auFileName: String?
    let aaxFileName: String?
    let manufacturer: Manufacturer
}
