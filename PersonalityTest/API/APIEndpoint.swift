//
//  Router.swift
//  PersonalityTest
//
//  Created by Taran  on 17/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import UIKit
import Alamofire

protocol Router {
    var route : String { get }
    var parameters : OptionalDictionary { get }
    func handle(data : Data?) -> Any?
    var method :  Alamofire.HTTPMethod { get }
}


// this extension is used to club value with keys and return dictionary
extension Sequence where Iterator.Element == Keys {
    
    func map(values: [Any?]) -> OptionalDictionary {
        
        var params = [String : Any]()
        
        for (index,element) in zip(self,values) {
            params[index.rawValue] = element
        }
        return params
        
    }
}


enum APIEndpoint {
    
    case getQuestions
    case submitQuestions(category : String?,selectedOption : [Int]?)
    
}

extension APIEndpoint : Router{


    var route : String  {
        
        switch self {
        case .getQuestions: return APIConstants.getQuestions
        case .submitQuestions: return APIConstants.submitQuestions
        }
        
    }
    
    var parameters: OptionalDictionary{
        return format()
    }
    
    
    func format() -> OptionalDictionary {
        
        switch self {
        case .getQuestions :
            return nil
        case .submitQuestions(let category,let selectedOption) :
            return Parameters.submitQuestions.map(values: [category, selectedOption])
            
        }
    }
    
    var method : Alamofire.HTTPMethod {
        switch self {
        case .submitQuestions(_) : return .post
        default: return .get
        }
    }
    
}
