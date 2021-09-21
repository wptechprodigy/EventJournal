//
//  TimeRemainingViewModel.swift
//  EventsJournal
//
//  Created by waheedCodes on 13/09/2021.
//

import UIKit

final class TimeRemainingViewModel {
    
    // MARK: - PROPERTIES
    
    enum Mode {
        case cell
        case detail
    }
    
    let timeRemainingParts: [String]
    private let mode: Mode
    
    var fontSize: CGFloat {
        switch mode {
        case .cell:
            return 25
        case .detail:
            return 60
        }
    }
    
    var alignment: UIStackView.Alignment {
        switch mode {
        case .cell:
            return .trailing
        case .detail:
            return .center
        }
    }
    
    // MARK: - INITIALIZERS
    
    init(timeRemainingParts: [String], mode: Mode) {
        self.timeRemainingParts = timeRemainingParts
        self.mode = mode
    }
}
