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
    
    func createInstalledPlugin(
        _ installedPlugin: InstalledPlugin,
        forUser user: User
    ) async throws -> InstalledPlugin {
        do {
            let documentReference = try firestore
                .collection(User.collectionName)
                .document(user.uid)
                .collection(InstalledPlugin.collectionName)
                .addDocument(from: installedPlugin)
            
            try await documentReference.updateData([
                Constants.FirestoreFields.id: documentReference.documentID
            ])
            
            var installedPluginWithID = installedPlugin
            installedPluginWithID.id = documentReference.documentID
            
            return installedPluginWithID
        } catch {
            throw error
            // TODO: HANDLE ERROR
        }
    }
    
    func getInstalledPlugin(
        withName pluginName: String,
        forUser user: User
    ) async throws -> InstalledPlugin? {
        do {
            let documentSnapshots = try await firestore
                .collection(User.collectionName)
                .document(user.uid)
                .collection(InstalledPlugin.collectionName)
                .whereField(Constants.FirestoreFields.name, isEqualTo: pluginName)
                .getDocuments()
                .documents
            
            guard documentSnapshots.count <= 1 else {
                print("❌ Found more than one plugin by name: \(pluginName)")
                return nil
            }
            
            if let installedPluginDocument = documentSnapshots.first {
                return try installedPluginDocument.data(as: InstalledPlugin.self)
            } else {
                // User does not have the InstalledPlugin
                return nil
            }
        } catch {
            throw error
            // TODO: HANDLE ERROR
        }
    }
    
    func updateInstalledPlugin(
        _ installedPlugin: InstalledPlugin,
        withNewFormat newFormat: String,
        forUser user: User
    ) async throws {
        do {
            try await firestore
                .collection(User.collectionName)
                .document(user.uid)
                .collection(InstalledPlugin.collectionName)
                .document(installedPlugin.id)
                .updateData([
                    Constants.FirestoreFields.installedFormats: FieldValue.arrayUnion([newFormat])
                ])
        } catch {
            throw error
            // TODO: Handle Error
        }
    }
}
