//
//  AddressAutoCompleterView.swift
//  TurnToTurn
//
//  Created by Yousef on 5/23/22.
//

import SwiftUI
import MapKit
import Combine

struct AddressAutoCompleterView: View {
    var label: String
    @StateObject private var addressCompleter: AddressCompleter
    @State private var showList: Bool = false
    var handler: (MKLocalSearchCompletion) -> Void
    
    init(regin: MKCoordinateRegion, label: String, handler: @escaping (MKLocalSearchCompletion) -> Void) {
        self.label = label
        self.handler = handler
        self._addressCompleter = StateObject(wrappedValue: .init(regin: regin))
    }
    
    var body: some View {
        ZStack {
            TextField(label, text: $addressCompleter.seachTerm)
                //            .font(.headline)
                .foregroundColor(.primary)
                .padding()
                .frame(height: 44)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.palette.bk)
                )
                .overlay(loading(), alignment: .trailing)
            
            if showList {
                addressesList
                    .frame(height: 300)
                    .offset(y: 190)
                    .zIndex(1)
            }
        }
        .frame(height: 44)
        .onReceive(addressCompleter.$searchResults, perform: { results in
            showList = !results.isEmpty && !addressCompleter.seachDone
        })
        .onChange(of: addressCompleter.seachTerm, perform: { value in
            if value.isEmpty {
                showList = false
            }
        })
        .zIndex(1)
    }
}


extension AddressAutoCompleterView {
    
    private var addressesList: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .leading) {
                ForEach(addressCompleter.searchResults, id:\.self) { location in
                    Button(action: {
                        selectLocation(for: location)
                    }, label: {
                        VStack(alignment: .leading) {
                            Text(location.title)
                            Text(location.subtitle)
                                .font(.system(.caption))
                            
                            if location != addressCompleter.searchResults.last {
                                Divider()
                            }
                        }
                        .foregroundColor(.primary)
                    })
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.palette.bk)
        )
    }
    
    @ViewBuilder
    private func loading() -> some View {
        if addressCompleter.isBusy {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.green))
                .padding(.trailing)
        }
    }
    
    func selectLocation(for location: MKLocalSearchCompletion) {
        addressCompleter.seachTerm = location.title
        addressCompleter.seachDone = true
        showList = false
        handler(location)
    }
}

struct AddressAutoCompleterView_Previews: PreviewProvider {
    static var previews: some View {
        AddressAutoCompleterView(regin: MKCoordinateRegion.defualt, label: "Search here...") { _ in }
     }
}


