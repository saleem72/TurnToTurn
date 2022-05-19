//
//  MapManagerError.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import Foundation

enum MapManagerError: Error, LocalizedError, Identifiable {
    case locationServicesDisabled
    case locationServicesRestricted
    case locationServicesDenied
    case addressNoPlaceMark
    case badRoute
    case other(Error)
    
    var errorDescription: String? {
        switch self {
        
        case .locationServicesDisabled:
            return "location services is disabled on your phone\r\nplease enabled it from your device settings"
        case .locationServicesRestricted:
            return "Your location is restricted likely due the parental controls."
        case .locationServicesDenied:
            return "You have denied this app location permission\r\nGo into settings to change it."
        case .addressNoPlaceMark:
            return "No place mark"
        case .badRoute:
            return "Couldn't retreaving your route for now\nplease try again later"
        case .other(let error):
            return error.localizedDescription
        }
    }
    
    var id: String {
        return UUID().uuidString
    }
    
    static func map(error: Error) -> MapManagerError {
        return (error as? MapManagerError ?? .other(error))
    }
    
}
