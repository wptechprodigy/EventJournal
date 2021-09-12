//
//  AppCoordinator.swift
//  EventsJournal
//
//  Created by waheedCodes on 03/09/2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    func start()
}

final class AppCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        let eventsListCoordinator = EventsListCoordinator(navigationController: navigationController)
        
        childCoordinators.append(eventsListCoordinator)
        eventsListCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
