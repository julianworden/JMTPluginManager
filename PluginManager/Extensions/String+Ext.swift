//
//  String+Ext.swift
//  PluginManager
//
//  Created by Julian Worden on 3/17/24.
//

import Foundation

extension String {
    /// Whether or not a given string is empty after removing all white spaces and new lines.
    var isReallyEmpty: Bool {
        return self.filter { !$0.isWhitespace && !$0.isNewline }.isEmpty
    }
    
    /// A version of a given string without any white spaces or new lines.
    var trimmed: String {
        return self.filter { !$0.isWhitespace && !$0.isNewline }
    }
    
    /// Returns the name of a plugin within a given string. Returns `self` if
    /// the given string is not a plugin name.
    ///
    /// This property only works properly if used on a plugin name string that includes
    /// the plugin's file extension. For instance, it would work on `"Fresh Air.vst"` but
    /// not on `"Fresh Air"`.
    var pluginNameWithoutFileExtension: String {
        guard self.isPluginName else { return self }
        
        // Add one to each count to account for "." before file extension name
        if self.isVSTPluginName {
            return String(self.dropLast(PluginFormat.vst.fileExtension.count + 1))
        } else if self.isVST3PluginName {
            return String(self.dropLast(PluginFormat.vst3.fileExtension.count + 1))
        } else if self.isAUPluginName {
            return String(self.dropLast(PluginFormat.au.fileExtension.count + 1))
        } else if self.isAAXPluginName {
            return String(self.dropLast(PluginFormat.aax.fileExtension.count + 1))
        } else {
            return self
        }
    }
    
    /// Returns a plugin's file extension within a given string, **not** including the "." before
    /// the file extension's name. For example, in `"Fresh Air.vst"`, this method
    /// would return `"vst"`. If the given string is not a plugin name, this method
    /// returns self.
    var pluginNameFileExtension: String {
        guard self.isPluginName else { return self }
        
        if self.isVSTPluginName {
            return String(self.suffix(PluginFormat.vst.fileExtension.count))
        } else if self.isVST3PluginName {
            return String(self.suffix(PluginFormat.vst3.fileExtension.count))
        } else if self.isAUPluginName {
            return String(self.suffix(PluginFormat.au.fileExtension.count))
        } else if self.isAAXPluginName {
            return String(self.suffix(PluginFormat.aax.fileExtension.count))
        } else {
            return self
        }
    }
    
    /// Whether or not a given string is the name of a VST plugin.
    var isVSTPluginName: Bool {
        return self.hasSuffix(".\(PluginFormat.vst.fileExtension)")
    }
    
    /// Whether or not a given string is the name of a VST3 plugin.
    var isVST3PluginName: Bool {
        return self.hasSuffix(".\(PluginFormat.vst3.fileExtension)")
    }
    
    /// Whether or not a given string is the name of an AU plugin.
    var isAUPluginName: Bool {
        return self.hasSuffix(".\(PluginFormat.au.fileExtension)")
    }
    
    /// Whether or not a given string is the name of an AAX plugin.
    var isAAXPluginName: Bool {
        return self.hasSuffix(".\(PluginFormat.aax.fileExtension)")
    }
    
    /// Whether or not a given string is the name of a VST, VST3, AU, or AAX plugin.
    var isPluginName: Bool {
        return isVSTPluginName ||
        isVST3PluginName ||
        isAUPluginName ||
        isAAXPluginName
    }
    
    /// Whether or not a string contains any special characters.
    var containsSpecialCharacter: Bool {
        let regex = ".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
    /// Whether or not a string contains both uppercase AND lowercase characters.
    var containsUpperAndLowercaseCharacters: Bool {
        var includesUppercase = false
        var includesLowercase = false
        
        for char in self {
            guard !includesLowercase || !includesUppercase else { break }
            
            if char.isUppercase {
                includesUppercase = true
            } else if char.isLowercase {
                includesLowercase = true
            }
        }
        
        return includesLowercase && includesUppercase
    }
}
