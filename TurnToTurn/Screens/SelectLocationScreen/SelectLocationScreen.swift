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
    
    let addTo: MapManager.AddedLocation
    
    init(addTo: MapManager.AddedLocation) {
        self.addTo = addTo
    }
    
    var body: some View {
        ZStack {
            
            LinearGradient.screen
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                VStack {
                    header
                    
                    Map(coordinateRegion: $manager.regin, showsUserLocation: true)
                        .edgesIgnoringSafeArea(.all)
                        .overlay(centerIndicator)
                        .onAppear {
//                            MKMapView.appearance().pointOfInterestFilter = .excludingAll
                            MKMapView.appearance().userTrackingMode = .followWithHeading
                        }
                }
                
                if manager.busyRequestionGeoAddress {
                    LoadingView()
                }
                
                if let _ = manager.requestionGeoAddressError {
                    ErrorView(error: $manager.requestionGeoAddressError)
                }
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showConfirmationMessage, content: savingAlert)
        .sheet(item: $manager.locationToAdd, content: sheetForLocation)
    }
    
    private func saveLocation() {
        manager.getLocationAddress(form: manager.regin)
    }
    
    private func proccedWithoutSaving() {
        manager.setLocation(coordinates: manager.regin.center, addTo: addTo)
        presentationMode.wrappedValue.dismiss()
    }
    
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
}

struct SelectLocationScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectLocationScreen(addTo: .destination)
            .preferredColorScheme(.dark)
            .environmentObject(MapManager())
    }
}

extension SelectLocationScreen {
    
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
//            manager.getLocationAddress(form: manager.regin)
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
//        .background(
//            Rectangle()
//                .fill(Color.white.opacity(0.2))
//                .blur(radius: 20)
//                .edgesIgnoringSafeArea(.top)
//        )
    }
    
    private var centerIndicator: some View {
//        ZStack {
//            Circle()
//                .fill(Color(.systemPink).opacity(0.5))
//                .frame(width: 44, height: 44)
//                .opacity(0.5)
//
//            Image(systemName: "plus.viewfinder")
//                .frame(width: 25, height: 25)
//                .foregroundColor(Color.white)
//        }
        
        MapCenterIndicator()
    }
    
}


