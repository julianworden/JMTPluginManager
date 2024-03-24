//
//  User.swift
//  PluginManager
//
//  Created by Julian Worden on 3/21/24.
//

import Foundation

struct User: Codable {
    /// The name of the collection that stores users in Firestore
    static let collectionName = "users"
    static let example = User(uid: "exampleuid", emailAddress: "example@example.com")
    
    let uid: String
    let emailAddress: String
}
