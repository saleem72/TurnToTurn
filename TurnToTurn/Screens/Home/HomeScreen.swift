//
//  HomeScreen.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct HomeScreen: View {
    
    var body: some View {
        ZStack {
            BackgroundView()
            Text("Home Screen")
        }
    }
}



struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .preferredColorScheme(.dark)
    }
}
