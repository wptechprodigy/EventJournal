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
    private let eventService: EventServiceProtocol
    
    // MARK: - INITIALIZERS
    
    init(eventService: EventServiceProtocol = EventService()) {
        self.eventService = eventService
    }
    
    func viewDidLoad() {
        reload()
    }
    
    func reload() {
        // For production purposes, it's better to reload the affected cell
        // or avoid caching the image statically on the EventCellViewModel
        EventCellViewModel.imageCache.removeAllObjects()
        let events = eventService.getEvents()
        cells = events.map {
            var eventCellViewModel = EventCellViewModel($0)
            if let coordinator = eventsListCoordinator {
                eventCellViewModel.onSelect = coordinator.onSelect
            }

            return .event(eventCellViewModel)
        }
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
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .event(let eventCellViewModel):
            eventCellViewModel.didSelect()
        }
    }
}
