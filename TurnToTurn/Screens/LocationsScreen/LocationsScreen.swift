//
//  LocationsScreen.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import SwiftUI

struct LocationsScreen: View {
    @StateObject private var dataManger: CoreDataManager = .shared
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundView = UIView()
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            content
        }
    }
}

extension LocationsScreen {
    
    private var content: some View {
        VStack {
            header
            locationsList
        }
    }
    
    private var locationsList: some View {
        List {
            ForEach(dataManger.locations) { location in
                LocationCard(location: location)
            }
            .onDelete(perform: dataManger.delete)
            .listRowBackground(Color.clear)
        }
    }
    
    private var header: some View {
        NavHeaderView(label: "Locations") { }
    }
}

struct LocationsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LocationsScreen()
            .preferredColorScheme(.dark)
    }
}



