//
//  AddNewLocationScreen.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/10/22.
//

import SwiftUI

struct AddNewLocationView: View {
    typealias AddNewLocationHandler = (Location) -> Void
    let location: Location
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var name: String = ""
    @State private var description: String = ""
    
    var handler: AddNewLocationHandler
    
    var isValid: Bool {
        name.count > 4
    }
    
    var addedLocation: Location {
        Location(
            name: name,
            city: location.city,
            address: location.address,
            description: description,
            createdAt: "",
            latitude: location.latitude,
            longitude: location.longitude
        )
    }
    
    init(location: Location, handler: @escaping AddNewLocationHandler) {
        self.location = location
        self.handler = handler
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Name: ")
                            .font(.headline)
                        TextField("Location name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Text("Description: ")
                            .font(.headline)
                        TextEditor(text: $description)
                            .frame(height: 250)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.secondary)
                            )
                        
                        Text("City: ")
                            .font(.headline) +
                            Text(location.city)
                        Text("Address: ")
                            .font(.headline) +
                        Text(location.address)
                        Text("Coordinates:\n")
                            .font(.headline) +
                        Text("\tlatitude: \(location.latitude)\n\tLongitude: \(location.longitude)")
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
            .navigationTitle("Add Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: toolbarButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension AddNewLocationView {
    func toolbarButton() -> some ToolbarContent {
        Group {
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                Button(action: {
                    handler(addedLocation)
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "square.and.arrow.down")
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                })
                .disabled(!isValid)
                .opacity(isValid ? 1 : 0.6)
            }
            
            ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark.square")
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                })
            }
        }
    }
}

struct AddNewLocationScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddNewLocationView(location: Location.eiffelTower) { _ in }
    }
}
