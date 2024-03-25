//
//  FileManagerError.swift
//  PluginManager
//
//  Created by Julian Worden on 3/25/24.
//

import Foundation

enum FileManagerError: LocalizedError {
    case failedToInspectDirectoryContents
    
    var errorDescription: String? {
        switch self {
        case .failedToInspectDirectoryContents:
            return "Failed to inspect contents of one or more directories. Please try again."
        }
    }
}
