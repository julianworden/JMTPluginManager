//
//  Manufacturer.swift
//  PluginManager
//
//  Created by Julian Worden on 3/11/24.
//

struct Manufacturer: Codable {
    /// The name of the collection that stores manufacturers in Firestore
    static let collectionName = "plugins"
    
    let id: String
    let name: String
    let website: String
}
