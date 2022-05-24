//
//  CustomMapPin.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/15/22.
//

import Foundation
import MapKit

class CustomMapPin: NSObject, MKAnnotation, Identifiable {

    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    
    var id: String {
        "\(coordinate.latitude),\(coordinate.longitude)"
    }

    init(coordinate: CLLocationCoordinate2D,
         title: String? = nil,
         subtitle: String? = nil
    ) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }

}
