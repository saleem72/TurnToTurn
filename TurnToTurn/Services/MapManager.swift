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
    @Published var userLocation: Location? = nil
    
    @Published var isTripReady: Bool = false
    @Published var sourceLocation: Location?
    @Published var destinationLocation: Location?
    
    @Published var regin: MKCoordinateRegion = .init()
    @Published var requestionGeoAddressError: MapManagerError?
    @Published var locationToAdd: Location? = nil
    @Published var busyRequestionGeoAddress: Bool = false
    
    @Published var gotoMapInstructions: Bool = false
    
    @Published var isInstructionLoading: Bool = false
    @Published var instructionError: MapManagerError? = nil
    
    @Published var selectedRoute: MKRoute? = nil
    
    lazy private var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = .greatestFiniteMagnitude
        return manager
    }()
    
    private var mapService = MapRelatedService()
    
}

//MARK: - Location Selection
extension MapManager {
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
    
    func setLocation(coordinates: CLLocationCoordinate2D, addTo: AddedLocation) {
        switch addTo {
        case .source:
            sourceLocation = Location(name: "Source", city: "", address: "", description: "", createdAt: "", latitude: coordinates.latitude, longitude: coordinates.longitude)
        case .destination:
            destinationLocation = Location(name: "Destination", city: "", address: "", description: "", createdAt: "", latitude: coordinates.latitude, longitude: coordinates.longitude)
        }
        updateTripEntries()
    }
    
    func add(location: Location, addTo: MapManager.AddedLocation) {
        //TODO: Find way to save this location for later (file, core data)
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
            if location.distance(from: userLocation.location) > 50 {
                self.updateUserLocation(for: location)
            }
        } else {
            updateUserLocation(for: location)
            withAnimation() {
                regin = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: Constants.reginRadius, longitudinalMeters: Constants.reginRadius)
            }
        }
    }
    
    private func updateUserLocation(for location: CLLocation) {
        userLocation = Location(name: "Current Location", city: "", address: "", description: "", createdAt: "", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
    
}

extension MapManager {
    private func fetchRoute(source: Location, destination: Location) {
        isInstructionLoading = true
        mapService.requestRoute(source: source.coordinates, destination: destination.coordinates) { [weak self] result in
            guard let self = self else { return }
            self.isInstructionLoading = false
            
            switch result {
            case .success(let route): // (coordinate: source)
                self.selectedRoute = route
            case .failure(let error):
                self.instructionError = error
            }
            
        }
    }
    
    func calculateRoute() {
        let source = sourceLocation != nil ? sourceLocation : userLocation
        guard let sourceLocation = source, let destination = destinationLocation else { return }
        
        fetchRoute(source: sourceLocation, destination: destination)
        
        
        gotoMapInstructions = true
    }
}
