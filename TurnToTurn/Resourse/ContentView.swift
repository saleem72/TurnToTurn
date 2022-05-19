//
//  ContentView.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct ContentView: View {
    @State private var procced: Bool = false
    var body: some View {
        if procced {
            MainTabView()
        } else {
            LandingScreen(procced: $procced)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MapManager())
    }
}
