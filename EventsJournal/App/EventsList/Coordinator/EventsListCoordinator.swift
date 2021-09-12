//
//  EventsListCoordinator.swift
//  EventsJournal
//
//  Created by waheedCodes on 03/09/2021.
//

import UIKit

final class EventsListCoordinator: Coordinator {
    
    // MARK: - PROPERTIES
    
    private(set) var childCoordinators: [Coordinator] = []
    var onSaveEvent = {}
    
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
        onSaveEvent = eventsListViewModel.reload
        eventsListViewController.viewModel = eventsListViewModel
        
        navigationController.setViewControllers([eventsListViewController], animated: false)
    }
    
    func startAddEvent() {
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        addEventCoordinator.parentCoordinator = self
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex (where: { coordinator in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
