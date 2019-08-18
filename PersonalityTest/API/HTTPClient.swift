//
//  HTTPClient.swift
//  PersonalityTest
//
//  Created by Taran  on 17/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import Foundation
import Alamofire

typealias HttpClientSuccess = (Any?) -> ()
typealias HttpClientFailure = (Error) -> ()

// MARK: - HTTPClient
class HTTPClient {
    
    var baseURL: String{
        return APIConstants.Basepath.Development
    }
    // this function is used to get the result from api that further pass to api handler to parse the data
    func postRequest(withApi api : Router , success : @escaping HttpClientSuccess,failure : @escaping HttpClientFailure){
        
        let fullPath = baseURL + api.route
        print(fullPath)
        print(api.parameters ?? "")
        
        
        Alamofire.request(fullPath, method: api.method, parameters: api.parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .success(_):
                success(response.data)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
}


