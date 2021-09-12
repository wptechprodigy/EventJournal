//
//  EventCell.swift
//  EventsJournal
//
//  Created by waheedCodes on 12/09/2021.
//

import UIKit

final class EventCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    private let yearLabel = UILabel()
    private let monthLabel = UILabel()
    private let weekLabel = UILabel()
    private let dayLabel = UILabel()
    private let emptyView = UIView()
    private let dateLabel = UILabel()
    
    private let eventNameLabel = UILabel()
    private let backgroundImageView = UIImageView()
    private let verticalStackView = UIStackView()
    
    
    // MARK: - INITIALIZERS
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViewElements()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    // MARK: - HELPER METHODS
    
    private func setupViewElements() {
        [yearLabel, monthLabel, weekLabel, dayLabel, dateLabel, eventNameLabel, backgroundImageView, verticalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        for label in [
            yearLabel,
            monthLabel,
            weekLabel,
            dayLabel,
            dateLabel,
            eventNameLabel
        ] {
            
            switch label {
            case dateLabel:
                label.font = .makeFont(ofSize: 20, fontWeight: .light)
            case eventNameLabel:
                label.font = .makeFont(ofSize: 26, fontWeight: .bold)
            default:
                label.font = .makeFont(ofSize: 24, fontWeight: .medium)
            }
            
            label.textColor = .white
        }
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .trailing
    }
    
    private func setupHierarchy() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(eventNameLabel)
        
        [
            yearLabel,
            monthLabel,
            weekLabel,
            dayLabel,
            emptyView,
            dateLabel
        ].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupLayout() {
        backgroundImageView.pinToSuperviewEdges([.left, .top, .right])
        
        // Fix for Unable to simultaneously satisfy constraints.
        //Probably at least one of the constraints in the following list is one you don't want.
        let bottomConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .required - 1
        bottomConstraint.isActive = true
        
        backgroundImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        verticalStackView.pinToSuperviewEdges([.top, .right, .bottom], constant: 16)
        eventNameLabel.pinToSuperviewEdges([.left, .bottom], constant: 16)
    }
    
    func update(with viewModel: EventCellViewModel) {
        yearLabel.text = viewModel.yearText
        monthLabel.text = viewModel.monthText
        weekLabel.text = viewModel.weekText
        dayLabel.text = viewModel.dayText
        dateLabel.text = viewModel.dateText
        eventNameLabel.text = viewModel.eventNameText
        backgroundImageView.image = viewModel.backgroundImage
    }
}
