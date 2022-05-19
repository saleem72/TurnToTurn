//
//  MapRelatedService.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import Foundation
import MapKit

struct MapRelatedService {
    
    typealias RouteRequestHandler = (Result<MKRoute, MapManagerError>) -> Void
    
    func reversedGeoLocationAddress(from coordinate: CLLocationCoordinate2D, complition: @escaping (Result<Location, MapManagerError>) -> Void) {
        
        let geoCoder = CLGeocoder()
        
        
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            
            if let error = error {
                let error = MapManagerError.map(error: error)
                complition(.failure(error))
                return
            }
            
            guard let placemark = placemarks?.first else {
                let error = MapManagerError.addressNoPlaceMark
                complition(.failure(error))
                return
            }
            
            let address = placemark.toAddress
            let city = placemark.locality ?? ""
            
            let location = Location(name: address, city: city, address: address, description: "some thing", createdAt: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
            complition(.success(location))
        }
        
    }
    
    private func prepareRequestForRoute(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) -> MKDirections.Request {
        let sourcePlacemark = MKPlacemark(coordinate: source, addressDictionary: nil)
        
        let destinationPlacemark = MKPlacemark(coordinate: destination, addressDictionary: nil)

        let sourceAnnotation = MKPointAnnotation()

        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }

        let destinationAnnotation = MKPointAnnotation()

        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        let request =  MKDirections.Request()
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        request.source = sourceMapItem
        request.destination = destinationMapItem
        request.transportType = .automobile
        
        return request
    }
    
    func requestRoute(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, complition: @escaping RouteRequestHandler) {
        
        let directionRequest = prepareRequestForRoute(source: source, destination: destination)
        let directions = MKDirections(request: directionRequest)

        directions.calculate { (response, error) in
            DispatchQueue.main.async {
//                self?.handleDirectionsResponse(response: response, error: error, complition: complition)
                
                guard let response = response else {
                    if let error = error {
                        print("Error: \(error)")
                        complition(.failure(MapManagerError.other(error)))
                    } else {
                        complition(.failure(MapManagerError.badRoute))
                    }
                    
                    return
                }
               
                if let route = response.routes.first {
                    complition(.success(route))
                } else {
                    complition(.failure(MapManagerError.badRoute))
                }
                
                
            }
        }
    }
    
    private func handleDirectionsResponse(response: MKDirections.Response?, error: Error?, complition: @escaping RouteRequestHandler) {
        guard let response = response else {
            if let error = error {
                print("Error: \(error)")
                complition(.failure(MapManagerError.other(error)))
            } else {
                complition(.failure(MapManagerError.badRoute))
            }
            
            return
        }
        
        let route = response.routes[0]
        complition(.success(route))
        
    }
}
