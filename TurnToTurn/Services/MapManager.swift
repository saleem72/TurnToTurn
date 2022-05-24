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
    
    @Published var isTripReady: Bool = false
    
    @Published var requestionGeoAddressError: MapManagerError?
    @Published var locationToAdd: Location? = nil
    @Published var busyRequestionGeoAddress: Bool = false
    
    @Published var gotoMapInstructions: Bool = false
    
    @Published var isInstructionLoading: Bool = false
    @Published var instructionError: MapManagerError? = nil
    
    @Published var selectedRoute: MKRoute? = nil
    @Published var directions: [MapStep] = []
    @Published var topStepIndex: Int? = nil
    @Published var pins: [CustomMapPin] = []
    @Published var tripDetails: TripDetails? = nil
    
    
    var sourceLocation: Location? {
        choosenLocation != nil ? choosenLocation : userLocation
    }
    
    @Published var userLocation: Location? = nil {
        didSet {
            if let value = userLocation {
                userRegin = MKCoordinateRegion(center: value.coordinates, latitudinalMeters: Constants.reginRadius, longitudinalMeters: Constants.reginRadius)
                
                sourceRegin = MKCoordinateRegion(center: value.coordinates, latitudinalMeters: Constants.reginRadius, longitudinalMeters: Constants.reginRadius)
            }
        }
    }
    @Published var choosenLocation: Location? {
        didSet {
            if let value = choosenLocation {
                sourceRegin = MKCoordinateRegion(center: value.coordinates, latitudinalMeters: Constants.reginRadius, longitudinalMeters: Constants.reginRadius)
            }
        }
    }
    @Published var destinationLocation: Location? {
        didSet {
            if let value = destinationLocation {
                destinationRegin = MKCoordinateRegion(center: value.coordinates, latitudinalMeters: Constants.reginRadius, longitudinalMeters: Constants.reginRadius)
            }
        }
    }
    
    
    @Published var userRegin: MKCoordinateRegion = .init()
    @Published var sourceRegin: MKCoordinateRegion = MKCoordinateRegion()
    @Published var destinationRegin: MKCoordinateRegion = MKCoordinateRegion()
    
    lazy private var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = .greatestFiniteMagnitude
        return manager
    }()
    
    var userMarks: [LocationEntity] {
        dataManger.locations
        
//        dataManger.locations.map({
//            Location(
//                name: $0.name ?? "",
//                city: "",
//                address: $0.address ?? "",
//                description: $0.details ?? "",
//                createdAt: "",
//                latitude: $0.latitude,
//                longitude: $0.longitude)
//        })
    }
    
    private var mapService = MapRelatedService()
    private let synth = AVSpeechSynthesizer()
    private var dataManger: CoreDataManager = .shared
    
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
            choosenLocation = Location(name: "Source", city: "", address: "", description: "", createdAt: "", latitude: coordinates.latitude, longitude: coordinates.longitude)
        case .destination:
            destinationLocation = Location(name: "Destination", city: "", address: "", description: "", createdAt: "", latitude: coordinates.latitude, longitude: coordinates.longitude)
        }
        updateTripEntries()
    }
    
    func add(location: Location, addTo: MapManager.AddedLocation) {
        //TODO: Find way to save this location for later (file, core data)
        
        dataManger.addLocation(location)
        
        switch addTo {
        case .source: choosenLocation = location
        case .destination: destinationLocation = location
        }
        updateTripEntries()
    }
    
    private func updateTripEntries() {
        isTripReady = sourceLocation != nil && destinationLocation != nil
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
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print(#function)
        guard directions.count > 0 else { return }
        
        // Real deal
        /*
        if let idx = directions.firstIndex(where: {$0.coordinate == regin.center}) {
            topStepIndex = idx
            synth.speak(directions[topStepIndex].voice)
            if idx == directions.indices.last {
                //MARK: Trip has ended
                endTrip()
            }
        }
        */
        
        // For test
        if var topStepIndex = topStepIndex {
            topStepIndex += 1
            synth.speak(directions[topStepIndex].voice)
            self.topStepIndex = topStepIndex
            if topStepIndex == directions.indices.last {
                //MARK: Trip has ended
                endTrip()
            }
        }
        
    }
    
    private func updateUserLocation(for location: CLLocation) {
        userLocation = Location(name: "Current Location", city: "", address: "", description: "", createdAt: "", latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        userRegin = .init(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    }
    
    func removeAllMonitoredRegins() {
        locationManager.monitoredRegions.forEach { regin in
            locationManager.stopMonitoring(for: regin)
        }
    }
    
    func startMonitoring(for regin: CLRegion) {
        locationManager.startMonitoring(for: regin)
    }
    
    func getCoordinates(for location: MKLocalSearchCompletion, complition: @escaping (MKMapItem?) -> Void) {
        let searchRequest = MKLocalSearch.Request(completion: location)
        let searcher = MKLocalSearch(request: searchRequest)
        searcher.start { (response, error) in
            guard error == nil else {
                debug("Error retriving coordinates: \(error!.localizedDescription)")
                complition(nil)
                return
            }
            guard let response = response else {
                complition(nil)
                return
            }
            
            guard let mapItem = response.mapItems.first else { return }
            complition(mapItem)
            
        }
    }
    
    func updateSourceAddress(for location: MKLocalSearchCompletion) {
        
        getCoordinates(for: location) { [weak self]  mapItem in
            guard let placemark = mapItem?.placemark else { return }
            DispatchQueue.main.async {
                self?.choosenLocation = Location(name: location.title, city: "", address: location.title + ", " + location.subtitle, description: "", createdAt: "", latitude: placemark.coordinate.latitude, longitude: placemark.coordinate.longitude)
                
                self?.updateTripEntries()
            }
        }
    }
    
    func updateDestinationAddress(for location: MKLocalSearchCompletion) {
        getCoordinates(for: location) { [weak self]  mapItem in
            guard let placemark = mapItem?.placemark else { return }
            DispatchQueue.main.async {
                self?.destinationLocation = Location(name: location.title, city: "", address: location.title + ", " + location.subtitle, description: "", createdAt: "", latitude: placemark.coordinate.latitude, longitude: placemark.coordinate.longitude)
                
                self?.updateTripEntries()
            }
        }
    }
}

extension MapManager {
    
    var tripLocations: [Location] {
       
        guard let sourceLocation = sourceLocation, let destination = destinationLocation else {return []}
        return [sourceLocation, destination]
    }
    
    private func fetchRoute(source: Location, destination: Location) {
        isInstructionLoading = true
        mapService.requestRoute(source: source.coordinates, destination: destination.coordinates) { [weak self] result in
            guard let self = self else { return }
            self.isInstructionLoading = false
            
            switch result {
            case .success(let route): // (coordinate: source)
                self.selectedRoute = route
                self.directions = route.steps.filter({!$0.instructions.isEmpty}).map(MapStep.init)
                if route.steps.count > 1 {
                    self.topStepIndex = 0
                }
            case .failure(let error):
                self.instructionError = error
            }
            
        }
    }
    
    func calculateRoute() {
        
        guard let sourceLocation = sourceLocation, let destination = destinationLocation else { return }
        
        fetchRoute(source: sourceLocation, destination: destination)
        pins = [
            .init(coordinate: sourceLocation.coordinates, title: sourceLocation.name),
            .init(coordinate: destination.coordinates, title: destination.name)
        ]
        
        gotoMapInstructions = true
    }
    
    private func endTrip() {
        let message = "You reached your destination"
        synth.speak(message)
        DispatchQueue.main.async { [weak self] in
            self?.selectedRoute = nil
            self?.pins.removeAll()
            self?.directions.removeAll()
        }
    }
}

//MARK: - Turn by Turn Map
extension MapManager {
    func tellFirstStep() {
        guard let string = directions.first?.voice else { return }
        synth.speak(string)
    }
}





