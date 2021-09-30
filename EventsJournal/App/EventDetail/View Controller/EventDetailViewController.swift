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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
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
        addEditButton()
        viewModel.viewDidLoad()
    }
    
    private func addEditButton() {
        navigationItem.rightBarButtonItem = .init(image: UIImage(
                                                    systemName: "pencil"),
                                                  style: .plain,
                                                  target: viewModel,
                                                  action: #selector(viewModel.didTapEditButton))
    }
}
