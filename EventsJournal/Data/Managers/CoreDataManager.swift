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
    
    func saveEvent(name: String, date: Date, image: UIImage) {
        let event = Event(context: managedObjectContext)
        event.setValue(name, forKey: "name")
        event.setValue(date, forKey: "date")
        
        let resizedImage = image.sameAspectRatio(newHeight: 250)
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateEvent(event: Event, name: String, date: Date, image: UIImage) {
        event.setValue(name, forKey: "name")
        event.setValue(date, forKey: "date")
        
        let resizedImage = image.sameAspectRatio(newHeight: 250)
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
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
}
