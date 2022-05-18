//
//  BackgroundView.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        backgroundLayer
    }
}

extension BackgroundView {
    
    private var backgroundLayer: some View {
        LinearGradient.screen
            .overlay(secondCircle, alignment: .bottom)
            .overlay(firstCircle)
            .edgesIgnoringSafeArea(.all)
    }
    
    private var firstCircle: some View {
        ZStack {
            Ellipse()
            .fill(AngularGradient(
                    gradient: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.2633333206176758, green: 0.64089035987854, blue: 0.987500011920929, alpha: 1)), location: 0.14994069933891296),
                .init(color: Color(#colorLiteral(red: 0.6176667213439941, green: 0.38333332538604736, blue: 1, alpha: 1)), location: 0.3641078472137451),
                .init(color: Color(#colorLiteral(red: 0.24480903148651123, green: 0.7176761627197266, blue: 0.9958333373069763, alpha: 1)), location: 0.5341951847076416),
                .init(color: Color(#colorLiteral(red: 0.047916680574417114, green: 0.22874994575977325, blue: 0.5, alpha: 1)), location: 0.8459962010383606)]),
                    center: UnitPoint(x: 0.5, y: 0.49999999999999994)
                  ))
        }
        .frame(width: 202, height: 201)
        .offset(x: (-UIScreen.main.bounds.width / 2) - (101 / 3) * 2)
        .blur(radius: 147.47)
    }
    
    private var secondCircle: some View {
        Circle()
            .fill(Color.fromHexString("AF3024"))
            .frame(width: 195, height: 195)
            .blur(radius: 143)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
            .preferredColorScheme(.dark)
    }
}
