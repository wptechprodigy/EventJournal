//
//  EventsListViewModel.swift
//  EventsJournal
//
//  Created by waheedCodes on 04/09/2021.
//

import Foundation

final class EventsListViewModel {
    
    // MARK: - PROPERTIES
    
    let title = "Events Journal"
    var eventsListCoordinator: EventsListCoordinator?
    
    enum Cell {
        case event(EventCellViewModel)
    }
    
    private(set) var cells: [Cell] = []
    var onUpdate = {}
    
    // MARK: - INITIALIZERS
    
    func viewDidLoad() {
        cells = [.event(EventCellViewModel()), .event(EventCellViewModel())]
        onUpdate()
    }
    
    // MARK: - METHODS
    
    func didTapAddEvent() {
        eventsListCoordinator?.startAddEvent()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(at indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
}
