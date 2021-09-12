//
//  UIView+Extensions.swift
//  EventsJournal
//
//  Created by waheedCodes on 12/09/2021.
//

import UIKit

extension UIView {
    
    enum Edge {
        case left
        case top
        case right
        case bottom
    }
    
    func pinToSuperviewEdges(_ edges: [Edge] = [.left, .top, .right, .bottom], constant: CGFloat = 0) {
        guard let superView = superview else { return }
        
        edges.forEach {
            switch $0 {
            case .left:
                leftAnchor.constraint(equalTo: superView.leftAnchor, constant: constant).isActive = true
            case .top:
                topAnchor.constraint(equalTo: superView.topAnchor, constant: constant).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -constant).isActive = true
            }
        }
    }
}
