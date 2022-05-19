//
//  GradientWithIconButtonModifire.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/9/22.
//

import SwiftUI

struct GradientWithIconButtonModifire: ViewModifier {
    
    let height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(height: 38)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(LinearGradient(colors: Color.white, Color.white), lineWidth: 1)
                    .padding(1)
                    .blendMode(.overlay)
            )
            .background(
                RoundedRectangle(cornerRadius: 40)
                    .fill(LinearGradient.button)
            )
    }
}

extension View {
    func gradientWithIconButton(height: CGFloat = 38) -> some View {
        modifier(GradientWithIconButtonModifire(height: 38))
    }
}

