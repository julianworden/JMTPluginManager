//
//  Array+Ext.swift
//  PluginManager
//
//  Created by Julian Worden on 3/27/24.
//

import Foundation

extension Array where Element == URL {
    /// Removes all URLs from a URL array that lead to a file that starts with a "."
    /// to get rid of URLs that lead to hidden files.
    var withoutHiddenFiles: [URL] {
        return self.filter { $0.lastPathComponent.first != "." }
    }
}
