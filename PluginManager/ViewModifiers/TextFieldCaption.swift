//
//  TextFieldCaption.swift
//  PluginManager
//
//  Created by Julian Worden on 3/17/24.
//

import SwiftUI

struct TextFieldCaption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.secondary)
            .font(.callout)
            .multilineTextAlignment(.leading)
    }
}

extension View {
    func textFieldCaption() -> some View {
        return self
            .modifier(TextFieldCaption())
    }
}
