//
//  ThickLabelModifire.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/9/22.
//

import SwiftUI

struct ThickLabelModifire: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.gallery.semiBold())
            .foregroundColor(Color.palette.secondary)
            .frame(height: 42)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.palette.tertiary)
            )
    }
}

extension View {
    func thickLabel() -> some View {
        modifier(ThickLabelModifire())
    }
}
