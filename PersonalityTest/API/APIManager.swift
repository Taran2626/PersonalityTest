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
        
        #warning("remove return to get response from api")
        completion(.success(getDataFromLocalJsonFile(api:api)))
        
        httpClient.postRequest(withApi:api , success: { (response) in
            let object = api.handle(data: response as? Data)
            completion(.success(object))

        }) { (error) in
            completion(.failure(error))
        }
        
        
    }
    

    func getDataFromLocalJsonFile(api : Router)->Any?{ // getting data from json file
        guard let path = Bundle.main.path(forResource: "TestJson", ofType: "json") else {return nil}
        let data = try? Data(contentsOf:URL(fileURLWithPath: path) , options: .alwaysMapped)
        return api.handle(data: data)
    }
}


