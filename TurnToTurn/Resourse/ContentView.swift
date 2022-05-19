//
//  ContentView.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var session: SessionManager = .init()
    
    var body: some View {
        
        ZStack {
            switch session.screen {
            case .home:
                MainTabView()
                    .transition(.asymmetric(insertion: .slide, removal: .opacity))
            case .splash:
                LandingScreen(session: session)
                    .transition(.opacity)
            default:
                LinearGradient.screen
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .onAppear(perform: session.checkStatus)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MapManager())
    }
}
