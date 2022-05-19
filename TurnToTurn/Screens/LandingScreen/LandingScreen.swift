//
//  LandingScreen.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/10/22.
//

import SwiftUI

struct LandingScreen: View {
    @ObservedObject private var session: SessionManager
    @State private var animated: Bool = false
    
    init(session: SessionManager) {
        self.session = session
    }
    
    var body: some View {
        ZStack {
            Color("screenFrom")
            Group {
                if animated {
                    AnimatedText(text: "Navigator")
                        .onAppear() {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                session.proccedToHome()
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
        LandingScreen(session: SessionManager())
    }
}


