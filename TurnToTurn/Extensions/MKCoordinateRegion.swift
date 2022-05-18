//
//  MKCoordinateRegion.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/11/22.
//

import Foundation
import MapKit

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center.latitude == rhs.center.latitude && lhs.center.longitude == rhs.center.longitude
    }
    
    
}
