//
//  Constants.swift
//  PersonalityTest
//
//  Created by Taran  on 17/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import Foundation
import UIKit

enum CellIdentifiers: String {
    case CategoryListCell = "CategoryListCell"
}


enum PhotoSourceType {
    case camera
    case gallery
}


struct StaticString {
    
    static let refreshTitle = "Pull to refresh"
    static let opps = "Opps"
    static let ok = "Ok"
    static let retry = "Retry"
    static let notAvailable = "not available"
    static let success = "Success"
    static let contactAdded = "Contact Added"
    static let selectOption = "Select Option"
    static let camera = "Camera"
    static let gallery = "Gallery"
    static let cancel =  "Cancel"
    static let contactEditedSuccessfully =  "Contact edited successfully"
    
}

struct SegueString {
    
    static let segueContactDetails = "segueContactDetails"
    
}
