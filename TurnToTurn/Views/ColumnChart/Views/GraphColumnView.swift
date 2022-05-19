//
//  GraphColumnView.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct GraphColumnView: View {
    
    var width: CGFloat
    var height: CGFloat
    var index: Int
        
    @State private var animated: Bool = false
    
    init(width: CGFloat, height: CGFloat, index: Int) {
        self.width = width
        self.height = height
        self.index = index
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient.button)
                .frame(width: max(width, 0), height: animated ? max(height, 0) : 0)
//                .frame(width: max(width, 0), height: max(height, 0))
                .clipShape(CustomRoundedShape(corners: [.topLeft, .topRight], radius: 8)).onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(Animation.interactiveSpring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.8).delay(Double(index) * 0.1)) {
                            animated = true
                        }
                    }

                }
        }
    }
    
}

