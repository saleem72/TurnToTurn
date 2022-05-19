//
//  Constants.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/10/22.
//

import Foundation
import MapKit

enum Constants {
    static var normalSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    static var currentLocationLabel = "Current Location"
    static var filename = "MyLocations.txt"
    static var routeSpan = MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
    static var reginRadius: Double = 500
}
