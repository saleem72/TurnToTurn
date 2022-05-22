//
//  LocationMarker.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/11/22.
//

import SwiftUI

struct LocationMarker: View {
    let location: Location
    var body: some View {
        VStack(spacing: 4) {
            Text(location.name)
                .font(.headline)
                .background(BlurView(style: .systemUltraThinMaterial, alpha: 0.7))
            ZStack {
                Image(systemName: "drop")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 40)
                    .rotationEffect(Angle(degrees: 180))
                    .background(BlurView(style: .systemUltraThinMaterial, alpha: 0.7))
                    .padding(.bottom, 30)
                Image(systemName: "circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
                    .offset(y: -20)
                
            }
        }
        .foregroundColor(Color.palette.red)
    }
}

struct LocationMarker_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient.screen
            LocationMarker(location: Location.eiffelTower)
        }
    }
}
