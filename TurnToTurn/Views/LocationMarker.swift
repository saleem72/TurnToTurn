//
//  LocationMarker.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/11/22.
//

import SwiftUI

struct LocationMarker: View {
    let label: String
    var body: some View {
        VStack(spacing: 0) {
            Text(label)
                .font(.headline)
                .frame(height: 20)
            ZStack {
                Image(systemName: "drop")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 40)
                    .rotationEffect(Angle(degrees: 180))
                Image(systemName: "circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
                    .offset(y: -7)
                
            }
        }
        .foregroundColor(Color.palette.red)
        .offset(y: -30)
    }
}

struct LocationMarker_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient.screen
            LocationMarker(label: "Eiffel Tower")
        }
    }
}
