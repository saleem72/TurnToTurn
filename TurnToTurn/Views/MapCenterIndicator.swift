//
//  MapCenterIndicator.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct MapCenterIndicator: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(.systemPink).opacity(0.5))
                .frame(width: 44, height: 44)
                .opacity(0.5)
            
            Image(systemName: "plus.viewfinder")
                .frame(width: 25, height: 25)
                .foregroundColor(Color.white)
        }
    }
}
