//
//  MKMapView+Extension.swift
//  TurnToTurn
//
//  Created by Yousef on 5/19/22.
//

import Foundation
import MapKit

extension MKMapView {
    func removeAllOverlays() {
        if !overlays.isEmpty {
            DispatchQueue.main.async {
                self.removeOverlays(self.overlays)
            }
        }
    }
}
