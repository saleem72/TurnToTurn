//
//  LocationIcon.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/9/22.
//

import SwiftUI

struct LocationIcon: View {
    var body: some View {
        ZStack {
            
            Circle()
                .fill(Color(#colorLiteral(red: 0.42178821563720703, green: 0.6949006915092468, blue: 0.8958333134651184, alpha: 0.20000000298023224)))
            .frame(width: 21.5, height: 21.5)
            
            ZStack {
                Circle()
                .fill(Color(#colorLiteral(red: 0.0010712742805480957, green: 1, blue: 0.8552954196929932, alpha: 1)))

                Circle()
                .strokeBorder(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), lineWidth: 2)
            }
            .frame(width: 11.3, height: 11.3)
        }
    }
}
