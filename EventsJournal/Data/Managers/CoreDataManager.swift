//
//  CoreDataManager.swift
//  EventsJournal
//
//  Created by waheedCodes on 03/09/2021.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    // MARK: - PROPERTIES
    
    static let shared = CoreDataManager()
    
    lazy var persistenceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EventsJournal")
        container.loadPersistentStores { (_, error) in
            print(error?.localizedDescription ?? "")
        }
        
        return container
    }()
    
    var managedObjectContext: NSManagedObjectContext {
        persistenceContainer.viewContext
    }
    
    // MARK: - FUNCTIONALITIES
    
    func get<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
        do {
            return try managedObjectContext.existingObject(with: id) as? T
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getAll<T: NSManagedObject>() -> [T] {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
            return try managedObjectContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func save() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
