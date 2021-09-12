//
//  UIViewController+Extensions.swift
//  EventsJournal
//
//  Created by waheedCodes on 03/09/2021.
//

import UIKit

extension UIViewController {
    
    // MARK: - PROPERTIES
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - METHODS
    
    static func instantiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: self.reuseIdentifier) as! T
        
        return viewController
    }
    
    // We could have this implemented as below without
    // the explicit definition of the reUseIdentifier property
    
    //    static func instantiate<T>() -> T {
    //        let storyboard = UIStoryboard(name: "Main", bundle: .main)
    //        let viewController = storyboard.instantiateViewController(withIdentifier: "\(T.self)") as! T
    //
    //        return viewController
    //    }
}
