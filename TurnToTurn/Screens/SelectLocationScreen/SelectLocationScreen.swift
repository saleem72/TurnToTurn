//
//  SelectLocationScreen.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI
import MapKit

struct SelectLocationScreen: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var manager: MapManager
    @State private var showConfirmationMessage: Bool = false
    
    private let addTo: MapManager.AddedLocation
    
    
    init(addTo: MapManager.AddedLocation) {
        self.addTo = addTo
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            content
            possibleLoading()
            possibleError()
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showConfirmationMessage, content: savingAlert)
        .sheet(item: $manager.locationToAdd, content: sheetForLocation)
    }
}


extension SelectLocationScreen {
    private func sheetForLocation(_ location: Location) -> some View {
        AddNewLocationView(location: location) { newLocation in
            manager.add(location: newLocation, addTo: addTo)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    private func savingAlert() -> Alert {
        Alert(
            title: Text("Save new location?"),
            message: Text("Do you want to save this location for later use"),
            primaryButton: Alert.Button.default(Text("Save location"), action: saveLocation),
            secondaryButton: .cancel(Text("Not now"), action: proccedWithoutSaving)
        )
    }
    
    private var content: some View {
        VStack {
            header
            selectionMap
        }
    }
    
    @ViewBuilder
    private func possibleLoading() -> some View {
        if manager.busyRequestionGeoAddress {
            LoadingView()
        }
    }
    
    @ViewBuilder
    private func possibleError() -> some View {
        if let _ = manager.requestionGeoAddressError {
            ErrorView(error: $manager.requestionGeoAddressError)
        }
    }
    
    private func setAnnotition(location: LocationEntity) -> MapAnnotation<LocationMarker> {
        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
            LocationMarker(label: location.name ?? "")
        }
    }
    
    private var selectionMap: some View {
        Map(
            coordinateRegion: addTo == .source ? $manager.sourceRegin : $manager.destinationRegin,
            annotationItems: manager.userMarks,
            annotationContent: setAnnotition
        )
        .edgesIgnoringSafeArea(.all)
        .overlay(centerIndicator)
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.backward")
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .navigationButton(direction: .leading)
        })
    }
    
    private var setLocationButton: some View {
        Button(action: {
            showConfirmationMessage = true
        }, label: {
            Image(systemName: "mappin.and.ellipse")
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .navigationButton(direction: .trailing)
        })
    }
    
    private var header: some View {
        HStack {
            backButton
            
            Spacer(minLength: 0)
            
            setLocationButton
        }
        .frame(height: 146)
        .overlay(
            Text("Select location")
                .font(Font.gallery.semiBold(17))
        )
    }
    
    private var centerIndicator: some View {
        MapCenterIndicator()
    }
    
}


extension SelectLocationScreen {
    
    private func saveLocation() {
        let regin = addTo == .source ? manager.sourceRegin : manager.destinationRegin
        manager.getLocationAddress(form: regin)
    }
    
    private func proccedWithoutSaving() {
        let regin = addTo == .source ? manager.sourceRegin : manager.destinationRegin
        manager.setLocation(coordinates: regin.center, addTo: addTo)
        presentationMode.wrappedValue.dismiss()
    }
}

struct SelectLocationScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectLocationScreen(addTo: .destination)
            .preferredColorScheme(.dark)
            .environmentObject(MapManager())
    }
}
