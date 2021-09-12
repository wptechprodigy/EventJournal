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

struct EventCellViewModel {
    
    // MARK: - PROPERTIES
    
    let date = Date()
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
    
    var backgroundImage: UIImage {
        guard let eventBackgroundImage = event.image else {
            return UIImage()
        }
        
        return UIImage(data: eventBackgroundImage) ?? UIImage()
    }
    
    private let event: Event
    
    // MARK: - INITIALIZERS
    
    init(_ event: Event) {
        self.event = event
    }
}
