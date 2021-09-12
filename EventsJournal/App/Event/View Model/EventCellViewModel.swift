//
//  EventCellViewModel.swift
//  EventsJournal
//
//  Created by waheedCodes on 12/09/2021.
//

// View model should be agnostic of whatever platform
// So, generally we shouldn't be importing UIKit in our VMs
// We could use the data type to handle the image but
// for this purpose, there's not much benefit to that...
import UIKit

struct EventCellViewModel {
    
    // MARK: - PROPERTIES
    
    var yearText: String {
        "1 year"
    }
    
    var monthText: String {
        "3 months"
    }
    
    var weekText: String {
        "1 week"
    }
    
    var dayText: String {
        "2 days"
    }
    
    var dateText: String {
        "12 Sept 2021"
    }
    
    var eventNameText: String {
        "Aashuuraa"
    }
    
    var backgroundImage: UIImage {
        #imageLiteral(resourceName: "New Leafs")
    }
}
