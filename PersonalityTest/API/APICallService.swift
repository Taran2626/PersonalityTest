//
//  APICallService.swift
//  PersonalityTest
//
//  Created by Taran  on 18/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import Foundation

protocol QuestionsServiceProtocol : class {
    func request(with api : Router , completion : @escaping (Result<Any?,Error>) -> ())
}

final class APICallService : QuestionsServiceProtocol {
    
    static let shared = APICallService()
    private lazy var httpClient : HTTPClient = HTTPClient()
    
    func request(with api : Router , completion : @escaping (Result<Any?,Error>) -> () )  {
        
        httpClient.postRequest(withApi:api , success: { (response) in
            let object = api.handle(data: response as? Data)
            completion(.success(object))
            
        }) { (error) in
            completion(.failure(error))
        }
        
    }
    
}

