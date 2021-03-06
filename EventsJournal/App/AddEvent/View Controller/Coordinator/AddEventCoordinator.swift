//
//  AddEventCoordinator.swift
//  EventsJournal
//
//  Created by waheedCodes on 04/09/2021.
//

import UIKit

final class AddEventCoordinator: Coordinator {
    
    // MARK: - PROPERTIES
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    private var completion: (UIImage) -> Void = { _ in }
    
    var parentCoordinator: EventsListCoordinator?
    
    // MARK: - INITIALIZERS
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.modalNavigationController = UINavigationController()
        let addEventViewController: AddEventViewController = .instantiate()
        let cellBuilder = EventCellBuilder()
        let addEventViewModel = AddEventViewModel(cellBuilder: cellBuilder)
        
        modalNavigationController?.setViewControllers([addEventViewController],
                                                     animated: false)
        addEventViewModel.coordinator = self
        addEventViewController.viewModel = addEventViewModel
        
        if let modalNavigationController = modalNavigationController {
            navigationController.present(modalNavigationController,
                                         animated: true,
                                         completion: nil)
        }
    }
    
    // Inform the parent coordinator, child is done for proper deallocation
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishSaveEvent() {
        parentCoordinator?.onUpdateEvent()
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func showImagePicker(completion: @escaping (UIImage) -> Void) {
        guard let modalNavigationController = modalNavigationController else { return }
        
        self.completion = completion
        
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavigationController)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.onFinishPicking = { image in
            completion(image)
            self.modalNavigationController?.dismiss(animated: true, completion: nil)
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
