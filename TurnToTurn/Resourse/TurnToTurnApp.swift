//
//  TurnToTurnApp.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

@main
struct TurnToTurnApp: App {
    
    @StateObject private var manager = MapManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
        }
    }
}
