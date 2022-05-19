//
//  MapManager.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI
import MapKit
import AVFoundation


class MapManager: NSObject, ObservableObject {
    
    enum AddedLocation {
        case source
        case destination
    }
    
    @Published var locationError: MapManagerError? = nil
    @Published var userLocation: CLLocation? = nil
    
    @Published var isTripReady: Bool = false
    @Published var sourceLocation: Location?
    @Published var destinationLocation: Location?
    
    @Published var regin: MKCoordinateRegion = .init()
    @Published var requestionGeoAddressError: MapManagerError?
    @Published var locationToAdd: Location? = nil
    @Published var busyRequestionGeoAddress: Bool = false
    
    lazy private var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = .greatestFiniteMagnitude
        return manager
    }()
    
    private var mapService = MapRelatedService()
    
    func calculateRoute() {
        
    }
    
    func getLocationAddress(form regin: MKCoordinateRegion) {
        busyRequestionGeoAddress = true
        mapService.reversedGeoLocationAddress(from: regin.center) { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.busyRequestionGeoAddress = false
            switch result {
            case .success(let location):
                self?.locationToAdd = location
            case .failure(let error):
                self?.requestionGeoAddressError = error
            }
        }
    }
    
    func add(location: Location, addTo: MapManager.AddedLocation) {
        switch addTo {
        case .source: sourceLocation = location
        case .destination: destinationLocation = location
        }
        updateTripEntries()
    }
    
    private func updateTripEntries() {
        let hasSource = sourceLocation != nil || userLocation != nil
        isTripReady = hasSource && destinationLocation != nil
    }
}


//MARK: - Location Delegate
extension MapManager: CLLocationManagerDelegate {
    
    /// It is importnat to call this func to activate location service
    ///
    /// it will check if location service is enabled on device if it is then it will start updating location service
    func checkIfLocationServiceEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            locationError = MapManagerError.locationServicesDisabled
        }
    }
    
    ///
    /// This func will ask for permission to use location service if it wasn't granted yet
    ///
    /// if there any issues related to location service permission it will publish an error descripe situation
    /// if every thing was ok it will start updating location
    ///
    private func checkLocationAuthorization() {
        
        switch locationManager.authorizationStatus {
        
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print(MapManagerError.locationServicesRestricted.localizedDescription)
            locationError = MapManagerError.locationServicesRestricted
        case .denied:
            print(MapManagerError.locationServicesDenied.localizedDescription)
            locationError = MapManagerError.locationServicesDenied
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        if let userLocation = userLocation {
            if location.distance(from: userLocation) > 50 {
                self.userLocation = location
            }
        } else {
            userLocation = location
            withAnimation() {
                regin = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: Constants.reginRadius, longitudinalMeters: Constants.reginRadius)
            }
        }
        
        
    }
    
}
