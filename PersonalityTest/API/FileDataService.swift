//
//  FileDataService.swift
//  PersonalityTest
//
//  Created by Taran on 18/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import Foundation

final class FileDataService : QuestionsServiceProtocol {
    
    static let shared = FileDataService()
    
    func request(with api : Router , completion : @escaping (Result<Any?,Error>) -> () )  {
        
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: "TestJson") else {
            completion(.failure(ErrorResult.custom(string: "No file or data")))
            return
        }
        
        completion(.success(api.handle(data: data)))
    }
}


extension FileManager {
    
    static func readJson(forResource fileName: String ) -> Data? {
        
        let bundle = Bundle(for: FileDataService.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                // handle error
            }
        }
        
        return nil
    }
}

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
