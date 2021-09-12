//
//  UITableViewCell+Extensions.swift
//  EventsJournal
//
//  Created by waheedCodes on 07/09/2021.
//

import UIKit

extension UITableViewCell {
    
    // MARK: - PROPERTIES
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
