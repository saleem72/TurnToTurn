//
//  Location.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/10/22.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable {
    let name: String
    let city: String
    let address: String
    let description: String
    let createdAt: String
    let latitude: Double
    let longitude: Double
    
    var id: String { name + city }
    
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
    static var eiffelTower: Location = Location(
        name: "Eiffel Tower",
        city: "Paris",
        address: "Champ de Mars, 5 Av. Anatole France, 75007 Paris, France",
        description: "The Eiffel Tower is a wrought-iron lattice tower on the Champ de Mars in Paris, France. It is named after the engineer Gustave Eiffel, whose company designed and built the tower.",
        createdAt: "",
        latitude: 48.858093,
        longitude: 2.294694
    )
}
