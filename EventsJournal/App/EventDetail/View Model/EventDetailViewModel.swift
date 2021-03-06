//
//  EventDetailViewModel.swift
//  EventsJournal
//
//  Created by waheedCodes on 13/09/2021.
//

import UIKit
import CoreData

final class EventDetailViewModel {
    
    // MARK: - PROPERTIES
    
    private let date = Date()
    private let eventID: NSManagedObjectID
    private let eventService: EventServiceProtocol
    private var event: Event?
    var onUpdate = {}
    
    var coordinator: EventDetailCoordinator?
    
    var image: UIImage? {
        guard let imageData = event?.image else { return nil }
        return UIImage(data: imageData)
    }
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard
            let eventDate = event?.date,
            let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else {
            return nil
        }
        
        return TimeRemainingViewModel(timeRemainingParts: timeRemainingParts,
                                      mode: .detail)
    }
    
    // MARK: - INITIALIZERS
    
    init(eventID: NSManagedObjectID,
         eventService: EventServiceProtocol = EventService()
    ) {
        self.eventID = eventID
        self.eventService = eventService
    }
    
    // MARK: - METHODS
    
    func viewDidLoad() {
        reload()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func reload() {
        event = eventService.getEvent(eventID)
        onUpdate()
    }
    
    @objc func didTapEditButton() {
        guard let event = event else { return }
        coordinator?.onEditEvent(event)
    }
}
