//
//  EditEventCoordinator.swift
//  EventsJournal
//
//  Created by waheedCodes on 23/09/2021.
//

import UIKit

final class EditEventCoordinator: Coordinator {
    
    // MARK: - PROPERTIES
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private var completion: (UIImage) -> Void = { _ in }
    private let event: Event
    var parentCoordinator: EventDetailCoordinator?
    
    // MARK: - INITIALIZERS
    
    init(event: Event, navigationController: UINavigationController) {
        self.event = event
        self.navigationController = navigationController
    }
    
    func start() {
        let editEventViewController: EditEventViewController = .instantiate()
        let cellBuilder = EventCellBuilder()
        let editEventViewModel = EditEventViewModel(event: event,
                                                    cellBuilder: cellBuilder)
        editEventViewModel.coordinator = self
        editEventViewController.viewModel = editEventViewModel
        navigationController.pushViewController(editEventViewController,
                                                animated: true)
    }
    
    // Inform the parent coordinator, child is done for proper deallocation
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishUpdatingEvent() {
        parentCoordinator?.onUpdateEvent()
        navigationController.popViewController(animated: true)
    }
    
    func showImagePicker(completion: @escaping (UIImage) -> Void) {
        self.completion = completion
        
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: navigationController)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.onFinishPicking = { image in
            completion(image)
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex (where: { coordinator in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}

