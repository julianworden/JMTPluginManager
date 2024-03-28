//
//  Manufacturer.swift
//  PluginManager
//
//  Created by Julian Worden on 3/11/24.
//

struct Manufacturer: Codable {
    /// The name of the collection that stores manufacturers in Firestore
    static let collectionName = "manufacturers"
    
    /// The manufacturer's document ID.
    let id: String
    /// The 4-digit key that is unique to this manufacturer.
    let key: String
    /// The name of the manufacturer.
    let name: String
    /// The manufacturer's website
    let website: String
    /// The manufacturer's support email address.
    let supportEmailAddress: String?
    /// The link to the manufacturer's support page of their website. The
    /// user should be able to use this page to submit a support request.
    /// Should only have a value if `supportEmailAddress` is `nil`.
    let supportWebsiteLink: String?
}
