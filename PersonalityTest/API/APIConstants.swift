//
//  APIConstants.swift
//  PersonalityTest
//
//  Created by Taran  on 17/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import Foundation

// MARK: - APIConstants
internal struct APIConstants {
    
    struct Basepath {
        static let Development = "https://api.myjson.com/bins"
    }
    
    static let getQuestions = "/s5vez"
    static let submitQuestions = "/s5vez"
    
}

enum MyError: Error {
    case runtimeError(String)
}

// MARK: - Keys
enum Keys : String{
    
    case category = "category"
    case selectedOption = "selected_option"

    
}

// MARK: - Validate
enum Validate : Int {
    
    case failure = 0
    case success = 200
    case invalidAccessToken = 401
    case adminBlocked = 403
    case none
    
    func map(response message : String?) -> String? {
        
        switch self {
        case .success, .failure, .invalidAccessToken, .adminBlocked :
            return message
        default:
            return nil
        }
    }
}

struct Parameters {
    static let submitQuestions : [Keys] = [.category, .selectedOption]
}

typealias OptionalDictionary = [String : Any]?
