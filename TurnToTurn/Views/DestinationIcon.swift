//
//  DestinationIcon.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/9/22.
//

import SwiftUI

struct DestinationIcon: View {
    var body: some View {
        ZStack {
            Image(systemName: "drop")
                .frame(width: 14, height: 20)
                .rotationEffect(Angle(degrees: 180))
                .foregroundColor(Color.palette.secondary)
            
            ZStack {
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(Color.palette.secondary)
                
                Circle()
                    .frame(width: 2, height: 2)
                    .foregroundColor(Color(.systemBackground))
            }
            .offset(y: -3)
        }
    }
}
