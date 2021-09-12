//
//  TitleSubtitleCellViewModel.swift
//  EventsJournal
//
//  Created by waheedCodes on 07/09/2021.
//

import UIKit

final class TitleSubtitleCellViewModel {
    
    // MARK: -
    typealias OnCellUpdate = () -> Void
    enum CellType {
        case text
        case date
        case image
    }
    
    // MARK: - PROPERTIES
    
    let title: String
    private(set) var subtitle: String
    let placeholder: String
    let type: CellType
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyy"
        return formatter
    }()
    private(set) var image: UIImage?
    private(set) var onCellUpdate: OnCellUpdate?
    
    init(title: String, subtitle: String = "", placeholder: String = "", type: CellType, onCellUpdate: OnCellUpdate?) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.type = type
        self.onCellUpdate = onCellUpdate
    }
    
    // MARK: - METHODS
    
    func update(_ subtitle: String) {
        self.subtitle = subtitle
    }
    
    func update(_ date: Date) {
        let dateString = dateFormatter.string(from: date)
        self.subtitle = dateString
        onCellUpdate?()
    }
    
    func update(_ image: UIImage) {
        self.image = image
        onCellUpdate?()
    }
}
