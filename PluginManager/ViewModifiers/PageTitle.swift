//
//  PageTitle.swift
//  PluginManager
//
//  Created by Julian Worden on 3/24/24.
//

import SwiftUI

struct PageTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
    }
}

extension View {
    func pageTitle() -> some View {
        return self
            .modifier(PageTitle())
    }
}
