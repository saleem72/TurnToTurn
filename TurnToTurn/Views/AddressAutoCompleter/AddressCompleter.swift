//
//  AddressCompleter.swift
//  TurnToTurn
//
//  Created by Yousef on 5/23/22.
//

import Foundation
import MapKit
import Combine

class AddressCompleter: NSObject, ObservableObject {
    
    @Published var searchResults = [MKLocalSearchCompletion]()
    @Published var seachTerm: String = ""
    @Published var isBusy: Bool = false
    @Published var seachDone: Bool = false
    
    @Published private(set) var regin: MKCoordinateRegion
    
    private var cancellables : Set<AnyCancellable> = []
    
    lazy private var searchManager: MKLocalSearchCompleter = {
        let manager = MKLocalSearchCompleter()
        manager.delegate = self
        manager.region = regin
        manager.resultTypes = .address
        return manager
    }()
    
    init(regin: MKCoordinateRegion) {
        self.regin = regin
        super.init()
        addSubscripers()
    }
    
    func addSubscripers() {
        $seachTerm
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] newTerm in
                self?.searchTermToResults(searchTerm: newTerm)
                self?.seachDone = false
            }
            .store(in: &cancellables)

    }
    
    func searchTermToResults(searchTerm: String) {
        if !isBusy && !seachTerm.isEmpty && !seachDone {
            isBusy = true
            searchManager.queryFragment = searchTerm
        }
    }
    
    func updateRegin(to regin: MKCoordinateRegion) {
        self.regin = regin
        searchManager.region = regin
    }
    
    func getCoordinates(for address: String) {
        
    }
}

extension AddressCompleter: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        isBusy = false
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        debug("some thing bad happend: \(error.localizedDescription)")
    }
}

extension AddressCompleter {
    enum SearchConstants {
        static let normalSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    }
}
