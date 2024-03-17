//
//  String+Ext.swift
//  PluginManager
//
//  Created by Julian Worden on 3/17/24.
//

import Foundation

extension String {
    var isReallyEmpty: String {
        return self.filter { !$0.isWhitespace && !$0.isNewline }
    }
    
    var containsSpecialCharacter: Bool {
        let regex = ".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        return testString.evaluate(with: self)
    }
    
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
