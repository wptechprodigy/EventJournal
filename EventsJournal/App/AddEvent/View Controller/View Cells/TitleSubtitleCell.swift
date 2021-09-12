//
//  TitleSubtitleCell.swift
//  EventsJournal
//
//  Created by waheedCodes on 07/09/2021.
//

import UIKit

final class TitleSubtitleCell: UITableViewCell {
    
    // MARK: - PROPERTIES
    
    private let titleLabel = UILabel()
    let subtitleTextField = UITextField()
    private let verticalStackView = UIStackView()
    
    lazy var datePickerView: UIDatePicker = {
        let datePicker = UIDatePicker()
        
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        return datePicker
    }()
    
    private let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    lazy var toolBarDoneButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done,
                        target: self,
                        action: #selector(tapToolBarDoneButton))
    }()
    
    let photoImageView = UIImageView()
    
    private(set) var viewModel: TitleSubtitleCellViewModel?
    
    // MARK: - VIEW LIFE CYCLE
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - METHODS
    
    func updateViewElements(with viewModel: TitleSubtitleCellViewModel) {
        let elementSpacing: CGFloat = 16
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.title
        subtitleTextField.text = viewModel.subtitle
        subtitleTextField.placeholder = viewModel.placeholder
        
        subtitleTextField.inputView = viewModel.type == .text ? nil : datePickerView
        subtitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolBar
        
        photoImageView.isHidden = viewModel.type != .image
        subtitleTextField.isHidden = viewModel.type == .image
        
        photoImageView.image = viewModel.image
        
        verticalStackView.spacing = elementSpacing
    }
    
    private func setupViews() {
        verticalStackView.axis = .vertical
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        subtitleTextField.font = .systemFont(ofSize: 20, weight: .regular)
        
        [verticalStackView, titleLabel, subtitleTextField, toolBar, datePickerView, photoImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        toolBar.setItems([toolBarDoneButton], animated: false)
        
        photoImageView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = 8
    }
    
    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleTextField)
        verticalStackView.addArrangedSubview(photoImageView)
    }
    
    private func setupLayout() {
        let constant: CGFloat = 16
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant),
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constant)
        ])
        
        photoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc private func tapToolBarDoneButton() {
        viewModel?.update(datePickerView.date)
    }
}
