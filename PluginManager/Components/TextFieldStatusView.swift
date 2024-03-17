//
//  TextFieldStatusView.swift
//  PluginManager
//
//  Created by Julian Worden on 3/17/24.
//

import SwiftUI

struct TextFieldStatusView: View {
    @Binding var inputIsValid: Bool
    
    let validMessage: String
    let invalidMessage: String
    
    var body: some View {
        HStack(spacing: 10) {
            if inputIsValid {
                Image(systemName: "checkmark")
                    .foregroundStyle(Color.green)
            } else {
                Text("X")
            }
            
            Group {
                Text(inputIsValid ? validMessage : invalidMessage)
            }
            .foregroundStyle(inputIsValid ? Color.green : Color.secondary)
        }
        .textFieldCaption()
    }
}
