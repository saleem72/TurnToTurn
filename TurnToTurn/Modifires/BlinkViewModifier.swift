//
//  BlinkViewModifier.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/16/22.
//

import SwiftUI

struct BlinkViewModifier: ViewModifier {
    
    let duration: Double
    @State private var blinking: Bool = false
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.palette.red)
            content
                .frame(width: 100, height: 44)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
                .opacity(blinking ? 0 : 1)
                .frame(width: 100, height: 44)
                .animation(Animation.easeOut(duration: duration).repeatForever())
        }
        .frame(width: 100, height: 44)
        .onAppear {
            withAnimation {
                blinking = true
            }
        }
    }
}

extension View {
    func blinking(duration: Double = 0.9) -> some View {
        modifier(BlinkViewModifier(duration: duration))
    }
}
