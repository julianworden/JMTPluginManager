//
//  URL+Ext.swift
//  PluginManager
//
//  Created by Julian Worden on 3/17/24.
//

import Foundation

extension URL {
    /// The total size of the contents of a directory at a given URL.
    ///
    /// Source: https://stackoverflow.com/questions/32814535/how-to-get-directory-size-with-swift-on-os-x
    var directorySize: Int64 {
        let contents: [URL]
        do {
            contents = try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: [.fileSizeKey, .isDirectoryKey])
        } catch {
            return 0
        }

        var size: Int64 = 0

        for url in contents {
            let isDirectoryResourceValue: URLResourceValues
            do {
                isDirectoryResourceValue = try url.resourceValues(forKeys: [.isDirectoryKey])
            } catch {
                continue
            }
        
            if isDirectoryResourceValue.isDirectory == true {
                size += url.directorySize
            } else {
                let fileSizeResourceValue: URLResourceValues
                do {
                    fileSizeResourceValue = try url.resourceValues(forKeys: [.fileSizeKey])
                } catch {
                    continue
                }
            
                size += Int64(fileSizeResourceValue.fileSize ?? 0)
            }
        }
        return size
    }
    
    /// The name of the plugin file at a given URL, not including the plugin's file extension. For
    /// example, in `"Fresh Air.vst"`, this property will only return `"Fresh Air"`.
    /// Returns `""Plugin Name Not Found"` if there is no plugin at the give URL.
    var pluginName: String {
        guard self.lastPathComponent.isPluginName else { return "Plugin Name Not Found" }
        
        return self.lastPathComponent.pluginNameWithoutFileExtension
    }
}
