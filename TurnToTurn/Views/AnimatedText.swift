//
//  AnimatedText.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct AnimatedText: View {
    let text: [String]
    @State private var animated: [Bool]
    init(text: String) {
        self.text = Array(text).map({String($0)})
        self._animated = State(initialValue: Array(repeating: false, count: text.count))
    }
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<text.count, id: \.self) { index in
                Text(String(text[index]))
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color.primary)
                    .offset(y: animated[index] ? 20 : 0)
                    .animation(Animation.linear(duration: 1.2).delay(0.1 * Double(index)).repeatForever())
                    
            }
        }
        .onAppear {
            withAnimation() {
                animated = animated.map({!$0})
            }
        }
    }
}
