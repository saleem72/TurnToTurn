//
//  MKCoordinateRegion.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/11/22.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    static var  defualt = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.776676, longitude: -73.971321),
        span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
}

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center.latitude == rhs.center.latitude && lhs.center.longitude == rhs.center.longitude
    }
    
    
}
