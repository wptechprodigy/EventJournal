//
//  TimeRemainingStackView.swift
//  EventsJournal
//
//  Created by waheedCodes on 13/09/2021.
//

import UIKit

final class TimeRemainingStackView: UIStackView {
    
    // MARK: - PROPERTIES
    
    private var timeRemainingLabels = [UILabel(), UILabel(), UILabel(), UILabel()]
    
    // MARK: - METHODS
    
    func setup() {
        timeRemainingLabels.forEach {
            addArrangedSubview($0)
        }
        
        axis = .vertical
        timeRemainingLabels.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func update(with viewModel: TimeRemainingViewModel) {
        
        timeRemainingLabels.forEach {
            $0.text = ""
            $0.font = .makeFont(ofSize: viewModel.fontSize,
                                fontWeight: .medium)
            $0.textColor = .white
        }
        
        viewModel.timeRemainingParts.enumerated().forEach {
            timeRemainingLabels[$0.offset].text = $0.element
        }
        
        alignment = viewModel.alignment
    }
}
