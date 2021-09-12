//
//  CoreDataManager.swift
//  EventsJournal
//
//  Created by waheedCodes on 03/09/2021.
//

import UIKit
import CoreData

final class CoreDataManager {
    
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
        let imageData = image.jpegData(compressionQuality: 1.0)
        event.setValue(imageData, forKey: "image")
        
        do {
            
            try managedObjectContext.save()
        } catch {
            
            print(error.localizedDescription)
        }
    }
    
    func fetchEvents() -> [Event] {
        
        do {
            
            let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
            let events = try managedObjectContext.fetch(fetchRequest)
            return events
        } catch {
            
            print(error.localizedDescription)
            return []
        }
    }
}
