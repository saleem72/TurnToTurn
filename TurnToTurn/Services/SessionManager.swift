//
//  SessionManager.swift
//  TurnToTurn
//
//  Created by Yousef on 5/19/22.
//

import SwiftUI

class SessionManager: ObservableObject {
    enum Screen {
        case splash
        case onBoarding
        case login
        case home
        case unKown
    }
    
    @Published var screen: Screen = .unKown
    
    func checkStatus() {
        screen = .splash
    }
    
    func proccedToHome() {
        withAnimation(.easeIn) {
            screen = .home
        }
    }
    
    
}
