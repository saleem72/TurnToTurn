//
//  TripDetails.swift
//  TurnToTurn
//
//  Created by Yousef on 5/19/22.
//

import Foundation

struct TripDetails {
    /// A TimeInterval value is always specified in seconds
    let expectedTravelTime: TimeInterval
    /// A distance measurement (measured in meters)
    let distance: Double
    let start: Date
    
    var end: Date {
        start.addingTimeInterval(expectedTravelTime)
    }
}
