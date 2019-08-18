//
//  APIManager.swift
//  PersonalityTest
//
//  Created by Taran  on 17/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//


import Foundation
import UIKit

// MARK: - APIManager
class APIManager{
    
    static let shared = APIManager()
    private lazy var httpClient : HTTPClient = HTTPClient()
    
    func request(with api : Router , completion : @escaping (Result<Any?,Error>) -> () )  {
        
        let object = api.handle(data: getJsonFromFile() as? Data)
        completion(.success(object))
        return
        
        httpClient.postRequest(withApi:api , success: { (response) in
            let object = api.handle(data: response as? Data)
            completion(.success(object))

        }) { (error) in
            completion(.failure(error))
        }
        
        
    }
    
    func getJsonFromFile()->Any?{
        
        guard let path = Bundle.main.path(forResource: "TestJson", ofType: "json") else {return nil}
        return try? Data(contentsOf:URL(fileURLWithPath: path) , options: .alwaysMapped)
    }
}


