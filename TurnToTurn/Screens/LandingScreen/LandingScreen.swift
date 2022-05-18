//
//  LandingScreen.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/10/22.
//

import SwiftUI

struct LandingScreen: View {
    @Binding var procced: Bool
    @State private var animated: Bool = false
    
    var body: some View {
        ZStack {
            Color("screenFrom")
            Group {
                if animated {
                    AnimatedText(text: "Navigator")
                        .onAppear() {
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                procced = true
                            }
                        }
                } else {
                    Text("Navigator")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color.primary)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.animated = true
            }
        }
    }
}

struct LandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreen(procced: .constant(false))
    }
}


