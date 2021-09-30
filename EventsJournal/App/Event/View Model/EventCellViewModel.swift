//
//  EventCellViewModel.swift
//  EventsJournal
//
//  Created by waheedCodes on 12/09/2021.
//

// View model should be agnostic of whatever platform
// So, generally we shouldn't be importing UIKit in our VMs
// We could use the data type to handle the image but
// for this purpose, there's not much benefit to that...
import UIKit
import CoreData

struct EventCellViewModel {
    
    // MARK: - PROPERTIES
    
    private let date = Date()
    static let imageCache = NSCache<NSString, UIImage>()
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    var onSelect: (NSManagedObjectID) -> Void = { _ in }
    
    private var cacheKey: String {
        event.objectID.description
    }
    
    var timeRemainingStrings: [String] {
        guard let eventDate = event.date else {
            return []
        }
        
        return date.timeRemaining(until: eventDate)?.components(separatedBy: ",") ?? []
    }
    
    var dateText: String? {
        guard let eventDate = event.date else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: eventDate)
    }
    
    var eventNameText: String? {
        event.name
    }
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard
            let eventDate = event.date,
            let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else {
            return nil
        }
        
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts,
                                      mode: .cell)
    }
    
    private let event: Event
    
    // MARK: - INITIALIZERS
    
    init(_ event: Event) {
        self.event = event
    }
    
    // MARK: - METHODS
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        // Check if the image is already in the cache with its value and then complete
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        } else {
            
            imageQueue.async {
                guard
                    let imageData = event.image,
                    let image = UIImage(data: imageData) else {
                    completion(nil)
                    return
                }
                
                // Set the image in the cache
                Self.imageCache.setObject(image, forKey: cacheKey as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    func didSelect() {
        onSelect(event.objectID)
    }
}
