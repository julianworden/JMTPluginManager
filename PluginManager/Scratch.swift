//
//  Scratch.swift
//  PluginManager
//
//  Created by Julian Worden on 3/16/24.
//

import SwiftUI

struct Scratch: View {
    @State var filename = "Filename"
    @State private var folderContentURLs = [URL]()
    @State private var fileNames = [String]()
    @State private var fileAttributes = [String]()
    @State var folderName = "Folder Name"
    @State var showFileChooser = false
    
    var body: some View {
        HStack {
            Text(folderName)
            
            VStack {
                ForEach(folderContentURLs, id: \.absoluteString) { url in
                    Text(url.absoluteString)
                }
            }
            
            VStack {
                ForEach(fileNames, id: \.self) { name in
                    Text(name)
                }
            }
            
            VStack {
                ForEach(fileAttributes, id: \.self) { attribute in
                    Text(attribute)
                }
            }
            
            Button("Select Folder") {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = true
                panel.canChooseFiles = false
                
                if panel.runModal() == .OK {
                    do {
                        let folder = panel.urls[0]
                        let contents = try FileManager.default.contentsOfDirectory(atPath: folder.path)
                        folderContentURLs = contents.map { folder.appendingPathComponent($0) }
                        FileManager.default.fileExists(atPath: "asdf")
                        try FileManager.default.contentsOfDirectory(atPath: folderContentURLs.first!.path)
                        fileNames = folderContentURLs.map { $0.pathComponents.last! }
                        
                        for url in folderContentURLs {
                            let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
                            var report: [String] = ["\(url.path)", ""]

                            // 4
                            for (key, value) in attributes {
                              // ignore NSFileExtendedAttributes as it is a messy dictionary
                              if key.rawValue == "NSFileExtendedAttributes" { continue }
                              report.append("\(key.rawValue):\t \(value)")
                            }
                            
                            fileAttributes = report
                        }
                    } catch {
                        print("ERROR: \(error)")
                    }
                }
            }
            
            Button("Select Folder") {
                let panel = NSOpenPanel()
                panel.allowsMultipleSelection = false
                panel.canChooseDirectories = true
                panel.canChooseFiles = false
                
                if panel.runModal() == .OK {
                    do {
                        let folder = panel.urls[0]
                        let contents = try FileManager.default.contentsOfDirectory(atPath: folder.path)
                        folderContentURLs = contents.map { folder.appendingPathComponent($0) }
                        FileManager.default.fileExists(atPath: "asdf")
                        try FileManager.default.contentsOfDirectory(atPath: folderContentURLs.first!.path)
                        fileNames = folderContentURLs.map { $0.pathComponents.last! }
                        FileAttributeKey.appendOnly
                        for url in folderContentURLs {
                            let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
                            var report: [String] = ["\(url.path)", ""]

                            // 4
                            for (key, value) in attributes {
                              // ignore NSFileExtendedAttributes as it is a messy dictionary
//                                  if key.rawValue == "NSFileExtendedAttributes" { continue }
                              report.append("\(key.rawValue):\t \(value)")
                            }
                            
                            fileAttributes = report
                            print(fileAttributes)
                            print("FILE SIZE: \(url.directorySize)")
                            
                            if url.absoluteString.contains(".aaxplugin") {
                                let plistURL = url.appendingPathComponent("Contents").appendingPathComponent("Info.plist")
                                print("PLIST AT: \(plistURL.absoluteString)")
                                let dictionary = NSDictionary(contentsOf: plistURL)
                                print(dictionary)
                                // Plugin Name
                                print("BUNDLE NAME: \(dictionary![kCFBundleNameKey])")
                                // Plugin Version
                                print("VERSION: \(dictionary![kCFBundleVersionKey])")
                            }
                        }
                    } catch {
                        print("ERROR: \(error)")
                    }
                }
            }
            
            
            // CHOOSE INDIVIDUAL FILE
    //            Text(filename)
    //            Button("select File") {
    //                let panel = NSOpenPanel()
    //                panel.allowsMultipleSelection = false
    //                panel.canChooseDirectories = false
    //                if panel.runModal() == .OK {
    //                    // GET DATE ADDED STRING FOR FILE SELECTED
    //                    let path = panel.url!.path()
    //                    if let mdItem = MDItemCreateWithURL(nil, panel.url! as CFURL),
    //                       let mdNames = MDItemCopyAttributeNames(mdItem),
    //                       let mdAttrs = MDItemCopyAttributes(mdItem, mdNames) as? [String: Any] {
    //                        print("ATTRIBUTES \(mdAttrs)")
    //                        let dateFormatter = DateFormatter()
    //                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    //                        let dateAdded = mdAttrs[kMDItemDateAdded as String] ?? "Unknown"
    //                        let version = mdAttrs[kMDItemEXIFGPSVersion as String]
    //                        print("VERSION: \(version)")
    //                        let dateAddedAsDate = dateAdded as? Date
    //                        let dateAddedAsString = dateFormatter.string(from: dateAddedAsDate!)
    //                        print("DATE ADDED: \(dateAddedAsString)")
    //                    } else {
    //                        print("CAN't Get attributes for \(path)")
    //                    }
    //                }
    //            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
