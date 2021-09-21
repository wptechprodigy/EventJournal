//
//  EventDetailViewController.swift
//  EventsJournal
//
//  Created by waheedCodes on 13/09/2021.
//

import UIKit

final class EventDetailViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var timeRemainingStackView: TimeRemainingStackView! {
        didSet {
            timeRemainingStackView.setup()
        }
    }
    var viewModel: EventDetailViewModel!

    // MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleUpdate()
    }
    
    // MARK: - HELPER METHODS
    
    private func handleUpdate() {
        viewModel.onUpdate = { [weak self] in
            guard
                let self = self,
                let timeRemainingViewModel = self.viewModel.timeRemainingViewModel else { return }
            
            self.backgroundImageView.image = self.viewModel.image
            self.timeRemainingStackView.update(with: timeRemainingViewModel)
        }
        
        viewModel.viewDidLoad()
    }
}
