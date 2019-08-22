//
//  APIHandler.swift
//  PersonalityTest
//
//  Created by Taran on 17/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import Foundation

//Api Handler
extension APIEndpoint {
    
    func handle(data : Data?) -> Any? {
        
        switch self {
        case .getQuestions:
            do {
                let object = try JSONDecoder().decode(QuestionModal.self, from: data!)
                return object
            }catch _ {
                return nil
            }
            case .submitQuestions(_): return nil
        }
        
        
        
    }
    
}
