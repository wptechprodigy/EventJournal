//
//  ImagePickerCoordinator.swift
//  EventsJournal
//
//  Created by waheedCodes on 08/09/2021.
//

import UIKit

final class ImagePickerCoordinator: NSObject, Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController?
    
    var parentCoordinator: AddEventCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        navigationController?.present(imagePickerController, animated: true, completion: nil)
    }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate
                                  & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            parentCoordinator?.didFinishPickingImage(selectedImage)
        }
        
        parentCoordinator?.childDidFinish(self)
    }
}
