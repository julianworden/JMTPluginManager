//
//  DatabaseService.swift
//  PluginManager
//
//  Created by Julian Worden on 3/21/24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

final class DatabaseService: DatabaseServiceProtocol {
    let firestore = Firestore.firestore()
    
    func createUser(_ user: User) throws {
        do {
            try firestore
                .collection(User.collectionName)
                .document(user.uid)
                .setData(from: user)
        } catch {
            // TODO: HANDLE ERROR
        }
    }
    
    func getUser(withUID uid: String) async throws -> User {
        do {
            return try await firestore
                .collection(User.collectionName)
                .document(uid)
                .getDocument(as: User.self)
        } catch {
            throw error
            // TODO: HANDLE ERROR
        }
    }
}
