//
//  AddEventViewController.swift
//  EventsJournal
//
//  Created by waheedCodes on 06/09/2021.
//

import UIKit

class AddEventViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: AddEventViewModel!

    // MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableView()
        
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.viewDidLoad()
        
        layoutNavigationItems()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    // MARK: - METHODS
    
    private func layoutNavigationItems() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(tappedDoneButton))
        
        // To force the large title to be displayed by default
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.setContentOffset(.init(x: 0, y: -1), animated: false)
    }
    
    private func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TitleSubtitleCell.self,
                           forCellReuseIdentifier: TitleSubtitleCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    @objc private func tappedDoneButton() {
        viewModel.tappedDone()
    }
}
