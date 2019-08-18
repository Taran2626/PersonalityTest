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
    case QuestionCell = "QuestionCell"
}


enum PhotoSourceType {
    case camera
    case gallery
}


struct StaticString {
    
    static let opps = "Opps"
    static let ok = "Ok"
    static let retry = "Retry"
    static let notAvailable = "not available"
    static let success = "Success"
    static let questionSubitMsg = "Your answer are submitted"
    
}

struct SegueString {
    
    static let segueQuestions = "SegueQuestions"
    
}
