//
//  StrokeWithIconButtonModifire.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/9/22.
//

import SwiftUI

struct StrokeWithIconButtonModifire: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 38)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(LinearGradient(colors: Color.palette.secondary, Color.palette.secondary))
            )
    }
}

extension View {
    func strokeWithIconButton() -> some View {
        modifier(StrokeWithIconButtonModifire())
    }
}
