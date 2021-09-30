//
//  EditEventViewModel.swift
//  EventsJournal
//
//  Created by waheedCodes on 23/09/2021.
//

import UIKit

final class EditEventViewModel {
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    // MARK: - PROPERTIES
    
    var title = "Edit Event"
    var onUpdate: () -> Void = {}
    private(set) var cells: [Cell] = []
    weak var coordinator: EditEventCoordinator?
    
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundCellViewModel: TitleSubtitleCellViewModel?
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyy"
        return formatter
    }()
    
    private let cellBuilder: EventCellBuilder
    private let coreDataManager: CoreDataManager
    private let event: Event
    
    // MARK: - INITIALIZERS
    
    init(
        event: Event,
        cellBuilder: EventCellBuilder,
        coreDataManager: CoreDataManager = CoreDataManager.shared)
    {
        self.event = event
        self.cellBuilder = cellBuilder
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - METHODS
    
    func viewDidLoad() {
        setUpCells()
        onUpdate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone() {
        
        // Extract info from the cell view model
        guard
            let name = nameCellViewModel?.subtitle,
            let dateString = dateCellViewModel?.subtitle,
            let date = dateFormatter.date(from: dateString),
            let image = backgroundCellViewModel?.image
        else { return }
        
        // Save in core data
        coreDataManager.updateEvent(event: event, name: name, date: date, image: image)
        
        // Tell coordinator to dismiss the add event view controller
        coordinator?.didFinishUpdatingEvent()
    }
    
    func updateCell(atIndexPath: IndexPath, subtitle: String) {
        
        switch cells[atIndexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
    
    func tapppedSelectImageRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.type == .image else {
                return
            }
            
            coordinator?.showImagePicker { image in
                // do something with image...
                titleSubtitleCellViewModel.update(image)
            }
        }
    }
}

private extension EditEventViewModel {
    func setUpCells() {
        nameCellViewModel = cellBuilder.makeTitleSubtitleViewModel(.text)
        dateCellViewModel = cellBuilder.makeTitleSubtitleViewModel(.date) { [weak self] in
            self?.onUpdate()
        }
        backgroundCellViewModel = cellBuilder.makeTitleSubtitleViewModel(.image) { [weak self] in
            self?.onUpdate()
        }
        guard
            let nameCellViewModel = nameCellViewModel,
            let dateCellViewModel = dateCellViewModel,
            let backgroundCellViewModel = backgroundCellViewModel else { return }
        
        cells = [
            .titleSubtitle(
                nameCellViewModel
            ),
            .titleSubtitle(
                dateCellViewModel
            ),
            .titleSubtitle(
                backgroundCellViewModel
            )
        ]
        
        guard
            let name = event.name,
            let date = event.date,
            let imageData = event.image,
            let image = UIImage(data: imageData)
        else { return }
        
        nameCellViewModel.update(name)
        dateCellViewModel.update(date)
        backgroundCellViewModel.update(image)
    }
}
