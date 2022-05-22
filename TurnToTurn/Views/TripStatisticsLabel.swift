//
//  TripStatisticsLabel.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/17/22.
//

import SwiftUI

struct TripStatisticsLabel: View {
    var value: String
    var label: String
    
    var body: some View {
        VStack {
            Text(value)
            Text(label)
                .foregroundColor(Color.palette.secondary)
        }
    }
}
