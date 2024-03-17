//
//  MainTextFieldStyle.swift
//  PluginManager
//
//  Created by Julian Worden on 3/16/24.
//

import SwiftUI

struct MainTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(height: 41)
            .textFieldStyle(PlainTextFieldStyle())
            .padding([.horizontal], 15)
            .background(Color.white)
            .cornerRadius(11)
    }
}

extension TextFieldStyle {
    func mainTextField() -> MainTextFieldStyle {
        return MainTextFieldStyle()
    }
}
