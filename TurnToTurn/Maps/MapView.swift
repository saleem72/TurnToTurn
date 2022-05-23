//
//  MapView.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/15/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    typealias MapReginChangeHandler = (CLLocation) -> Void
    
    @ObservedObject private var manager: MapManager
    
    let handler: MapReginChangeHandler
    
    init(manager: MapManager, handler: @escaping MapReginChangeHandler) {
        self.manager = manager
        self.handler = handler
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.showsUserLocation = true
        addRoute(to: mapView)
        mapView.addAnnotations(manager.pins)
        addMonitoredRegins(mapView: mapView)
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.delegate = context.coordinator
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func dismantleUIView(_ mapView: MKMapView, coordinator: Coordinator) {
        print(#function)
        DispatchQueue.main.async {
            mapView.annotations.forEach { annotition in
                mapView.removeAnnotation(annotition)
            }
            
            mapView.overlays.forEach { overlay in
                mapView.removeOverlay(overlay)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        let parent: MapView
        init(parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//            dump(overlay)
            if overlay is MKPolyline {
                let renderer = MKPolylineRenderer(overlay: overlay)
                renderer.fillColor = UIColor.systemPink.withAlphaComponent(0.5)
                renderer.strokeColor = UIColor.systemPink.withAlphaComponent(0.8)
                renderer.lineWidth = 5
                
                return renderer
            }
            
            if let circle = overlay as? MKCircle {
                let renderer = MKCircleRenderer(circle: circle)
                renderer.fillColor = UIColor.systemPink.withAlphaComponent(0.5)
                renderer.strokeColor = UIColor.systemPink.withAlphaComponent(0.8)
                renderer.lineWidth = 5
                
                return renderer
            }
            
            return MKOverlayRenderer()
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            let newLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
            parent.handler(newLocation)
        }
    }
    
}

private extension MapView {
    func addRoute(to mapView: MKMapView) {
        mapView.removeAllOverlays()

        guard let route = manager.selectedRoute else { return }
        if let regin = findRegin(mapView: mapView) {
            mapView.setRegion(regin, animated: true)
        } else  {
            mapView.setRegion(manager.sourceRegin, animated: true)
        }
        mapView.addOverlay(route.polyline)
        
        // shows the steps on the route
//        addRouteRegins(mapView: mapView)
    }
    
    // regin to fit route polyline and centered at user location
    private func findRegin(mapView: MKMapView) -> MKCoordinateRegion? {
        
        if let sourceLocation = manager.sourceLocation?.location, let destinationLocation = manager.destinationLocation?.location {
            let newDistance = sourceLocation.distance(from: destinationLocation)
            let region = MKCoordinateRegion(center: sourceLocation.coordinate, latitudinalMeters: 2 * newDistance, longitudinalMeters: 2 * newDistance)
              let adjustRegion = mapView.regionThatFits(region)
              return adjustRegion
        }
        
        return nil
        
    }
    
    private func addRouteRegins(mapView: MKMapView) {
        guard manager.directions.count > 0  else { return }
        for idx in manager.directions.indices {
            let step = manager.directions[idx]
            let circle = MKCircle(center: step.coordinate, radius: 20)
            mapView.addOverlay(circle)
        }
    }
    
    private func addMonitoredRegins(mapView: MKMapView) {
        guard manager.directions.count > 0 else { return }
        manager.removeAllMonitoredRegins()
        for idx in manager.directions.indices {
            let step = manager.directions[idx]
            let regin = CLCircularRegion(center: step.coordinate, radius: 20, identifier: "\(idx)")
            manager.startMonitoring(for: regin)
        }
    }
}
