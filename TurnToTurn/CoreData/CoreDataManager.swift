//
//  CoreDataManager.swift
//  TurnToTurn
//
//  Created by Yousef on 5/23/22.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    
    @Published private(set) var locations = [LocationEntity]()
    
    static var shared = CoreDataManager()
    
    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(name: "TurnToTurnDataModel")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                debug("Can't load core data: \(error.localizedDescription)")
            }
        }
        
        context = container.viewContext
        loadAllLocations()
    }
    
    func loadAllLocations() {
        let request: NSFetchRequest<LocationEntity> = LocationEntity.fetchRequest()
        
        do {
            locations = try context.fetch(request)
            locations.forEach({print("\($0.latitude), \($0.longitude)")})
        } catch {
            debug("Can't load locations: \(error.localizedDescription)")
        }
    }
    
    func trySave() {
        do {
            try context.save()
            loadAllLocations()
        } catch {
            debug("Can't save data: \(error.localizedDescription)")
        }
    }
    
    func addLocation(_ location: Location) {
        let entity = LocationEntity(context: context)
        entity.name = location.name
        entity.details = location.description
        entity.address = location.address
        entity.latitude = location.latitude
        entity.longitude = location.longitude
        
        trySave()
    }
    
    func delete(at offsets: IndexSet) {
        offsets.map({locations[$0]}).forEach({context.delete($0)})
        trySave()
    }
    
}
