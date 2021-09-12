//
//  EventCellBuilder.swift
//  EventsJournal
//
//  Created by waheedCodes on 09/09/2021.
//

import Foundation

struct EventCellBuilder {
    
    func makeTitleSubtitleViewModel(_ type: TitleSubtitleCellViewModel.CellType, onCellUpdate: (() -> Void)? = nil) -> TitleSubtitleCellViewModel {
        switch type {
        case .text:
            return TitleSubtitleCellViewModel(title: "Name",
                                              placeholder: "Add a name...",
                                              type: .text,
                                              onCellUpdate: onCellUpdate)
        case .date:
            return TitleSubtitleCellViewModel(title: "Date",
                                              placeholder: "Add a date...",
                                              type: .date,
                                              onCellUpdate: onCellUpdate)
        case .image:
            return TitleSubtitleCellViewModel(title: "Background",
                                              type: .image,
                                              onCellUpdate: onCellUpdate)
        }
    }
}
