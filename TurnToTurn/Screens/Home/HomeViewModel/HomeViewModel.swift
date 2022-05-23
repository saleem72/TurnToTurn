//
//  HomeViewModel.swift
//  TurnToTurn
//
//  Created by Yousef on 5/18/22.
//

import Foundation
import MapKit

class HomeViewModel: ObservableObject {
    @Published var showDestinationList: Bool = false
    @Published var showStartList: Bool = false
    
    @Published var gotoMapSelectionDestination: Bool = false
    @Published var gotoMapSelectionSource: Bool = false
    
    @Published var isSourceBusy: Bool = false
    @Published var isDestinationBusy: Bool = false
    
}
