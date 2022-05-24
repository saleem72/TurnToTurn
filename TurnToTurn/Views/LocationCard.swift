//
//  LocationCard.swift
//  TurnToTurn
//
//  Created by Yousef on 5/24/22.
//

import SwiftUI

struct LocationCard: View {
    
    var location: LocationEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            
            SplitedHStack {
                Text("Name: ")
                    .font(.headline)
            } right: {
                Text(location.name ?? "")
                    .font(.headline)
            }

            SplitedHStack {
                Text("Description: ")
                    .font(.headline)
            } right: {
                Text(location.details ?? "")
                    .font(.caption)
            }
            
            SplitedHStack {
                Text("Address: ")
                    .font(.headline)
            } right: {
                Text(location.address ?? "")
                    .font(.caption)
            }
             
            HStack {
                
                SplitedHStack {
                    Text("latitude: ")
                        .font(.headline)
                } right: {
                    Text(location.latitude.removeExtraZeros())
                        .font(.caption)
                }
                .setWidth(to: 80)
                
                SplitedHStack(alignment: .center) {
                    Text("longitude: ")
                        .font(.headline)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                } right: {
                    Text(location.longitude.removeExtraZeros())
                        .font(.caption)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .setWidth(to: 80)
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.palette.tertiary)
        )
    }
}

