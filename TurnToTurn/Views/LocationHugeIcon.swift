//
//  LocationHugeIcon.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/9/22.
//

import SwiftUI

struct LocationHugeIcon: View {
    var body: some View {
        ZStack {
            Image(systemName: "drop.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotationEffect(Angle(degrees: 180))
                .frame(width: 81.32, height: 107.45)
                .foregroundColor(Color.fromHexString("#018CF1").opacity(0.2))
            
            
            LinearGradient.location // 60.99 81.32
                .frame(width: 60.99, height: 81.32)
                .mask(
                    Image(systemName: "drop.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .rotationEffect(Angle(degrees: 180))
            )
            
            Circle()
                .fill(Color.white)
                .frame(width: 2.9, height: 2.9)
                .offset(y: 45)
            
            Circle()
                .fill(Color.white)
                .frame(width: 23.23, height: 23.23)
                .offset(y: -20)
        }
    }
}
