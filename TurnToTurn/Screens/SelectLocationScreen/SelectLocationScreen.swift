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
    
    let addTo: MapManager.AddedLocation
    
    init(addTo: MapManager.AddedLocation) {
        self.addTo = addTo
    }
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $manager.regin, showsUserLocation: true)
                .edgesIgnoringSafeArea(.all)
                .overlay(centerIndicator)
            
            ZStack {
                VStack {
                    header
                    
                    Spacer()
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
        .sheet(item: $manager.locationToAdd) { location in
            AddNewLocationView(location: location) { newLocation in
                manager.add(location: newLocation, addTo: addTo)
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct SelectLocationScreen_Previews: PreviewProvider {
    static var previews: some View {
        SelectLocationScreen(addTo: .destination)
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
                .foregroundColor(.black)
                .frame(width: 44, height: 44)
        })
    }
    
    private var setLocationButton: some View {
        Button(action: {
            manager.getLocationAddress(form: manager.regin)
        }, label: {
            Image(systemName: "mappin.and.ellipse")
                .font(.title2)
                .foregroundColor(.black)
                .frame(width: 44, height: 44)
        })
    }
    
    private var header: some View {
        HStack {
            backButton
                .padding(.leading)
            
            Spacer(minLength: 0)
            
            setLocationButton
                .padding(.trailing)
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            BlurView(style: .systemThinMaterial, alpha: 0.8)
                .edgesIgnoringSafeArea(.top)
        )
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


