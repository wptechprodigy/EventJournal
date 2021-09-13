//
//  EventDetailCoordinator.swift
//  EventsJournal
//
//  Created by waheedCodes on 13/09/2021.
//

import UIKit
import CoreData

final class EventDetailCoordinator: Coordinator {
    
    // MARK: - PROPERTIES
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    private let eventID: NSManagedObjectID
    
    // MARK: - INITIALIZERS
    
    init(eventID: NSManagedObjectID, navigationController: UINavigationController) {
        self.eventID = eventID
        self.navigationController = navigationController
    }
    
    // MARK: - METHODS
    
    func start() {
        let eventDetailViewController: EventDetailViewController = .instantiate()
        eventDetailViewController.viewModel = EventDetailViewModel(eventID: eventID)
        navigationController.pushViewController(eventDetailViewController, animated: true)
    }
}
