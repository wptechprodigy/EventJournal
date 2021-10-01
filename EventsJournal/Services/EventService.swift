//
//  EventService.swift
//  EventsJournal
//
//  Created by waheedCodes on 30/09/2021.
//

import UIKit
import CoreData

// MARK: -

struct EventInputData {
    let name: String
    let date: Date
    let image: UIImage
}

protocol EventServiceProtocol {
    func perform(_ action: EventAction, _ data: EventInputData)
    func getEvent(_ id: NSManagedObjectID) -> Event?
    func getEvents() -> [Event]
}

final class EventService: EventServiceProtocol {
    
    // MARK: - PROPERTIES
    
    private let coreDataManager: CoreDataManager
    
    // MARK: - INITIALIZERS
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - OPERATIONS
    
    func perform(_ action: EventAction, _ data: EventInputData) {
        var event: Event
        
        switch action {
        case .add:
            event = Event(context: coreDataManager.managedObjectContext)
        case .update(let eventToUpdate):
            event = eventToUpdate
        }
        
        event.setValue(data.name, forKey: "name")
        event.setValue(data.date, forKey: "date")
        
        let resizedImage = data.image.sameAspectRatio(newHeight: 250)
        let imageData = resizedImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        
        coreDataManager.save()
    }
    
    func getEvent(_ id: NSManagedObjectID) -> Event? {
        return coreDataManager.get(id)
    }
    
    func getEvents() -> [Event] {
        return coreDataManager.getAll()
    }
}
