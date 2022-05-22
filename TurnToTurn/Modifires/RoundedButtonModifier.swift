//
//  RoundedButtonModifier.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/19/22.
//

import SwiftUI

struct RoundedButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            content
        }
        .frame(width: 44, height: 44)
        .background(
            Circle()
                .fill(Color.white.opacity(0.1))
        )
    }
}

extension View {
    func roundedButton() -> some View {
        modifier(RoundedButtonModifier())
    }
}
