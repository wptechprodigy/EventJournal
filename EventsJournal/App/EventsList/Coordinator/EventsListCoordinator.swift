//
//  EventsListCoordinator.swift
//  EventsJournal
//
//  Created by waheedCodes on 03/09/2021.
//

import UIKit
import CoreData

final class EventsListCoordinator: Coordinator {
    
    // MARK: - PROPERTIES
    
    private(set) var childCoordinators: [Coordinator] = []
    var onUpdateEvent = {}
    
    private let navigationController: UINavigationController
    
    // MARK: - INITIALIZERS
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - METHODS
    
    func start() {
        let eventsListViewController: EventsListViewController = .instantiate()
        let eventsListViewModel = EventsListViewModel()
        
        eventsListViewModel.eventsListCoordinator = self
        onUpdateEvent = eventsListViewModel.reload
        eventsListViewController.viewModel = eventsListViewModel
        
        navigationController.setViewControllers([eventsListViewController], animated: false)
    }
    
    func startAddEvent() {
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        addEventCoordinator.parentCoordinator = self
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }
    
    func onSelect(_ id: NSManagedObjectID) {
        let eventDetailCoordinator = EventDetailCoordinator(
            eventID: id,
            navigationController: navigationController)
        
        childCoordinators.append(eventDetailCoordinator)
        eventDetailCoordinator.parentCoordinator = self
        eventDetailCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex (where: { coordinator in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
