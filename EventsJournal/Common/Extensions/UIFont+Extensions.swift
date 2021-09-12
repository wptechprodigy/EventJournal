//
//  UIFont+Extensions.swift
//  EventsJournal
//
//  Created by waheedCodes on 12/09/2021.
//

import UIKit

extension UIFont {
    
    enum FontWeight {
        case light
        case regular
        case medium
        case bold
    }
    
    static func makeFont(ofSize size: CGFloat, fontWeight: FontWeight) -> UIFont {
        switch fontWeight {
        case .light:
            return UIFont.systemFont(ofSize: size, weight: .light)
        case .regular:
            return UIFont.systemFont(ofSize: size, weight: .regular)
        case .medium:
            return UIFont.systemFont(ofSize: size, weight: .medium)
        case .bold:
            return UIFont.systemFont(ofSize: size, weight: .bold)
        }
    }
}
