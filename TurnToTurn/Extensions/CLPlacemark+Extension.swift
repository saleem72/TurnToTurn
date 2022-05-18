//
//  CLPlacemark+Extension.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/12/22.
//

import Foundation
import CoreLocation

extension CLPlacemark {
    var toAddress: String {
        let subAdministrativeArea = self.subAdministrativeArea ?? ""
        let locality = self.locality ?? ""
        let subLocality = self.subLocality ?? ""
        let streetNumber = self.subThoroughfare ?? ""
        let streetName = self.thoroughfare ?? ""
        
        let address = "\(subAdministrativeArea) \(locality) \(subLocality) \(streetNumber) \(streetName)"
        return address
    }
}
