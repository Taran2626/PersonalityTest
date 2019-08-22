//
//  QuestionViewModal.swift
//  PersonalityTest
//
//  Created by Taran on 18/08/19.
//  Copyright © 2019 Taranjeet_MacBook. All rights reserved.
//

import UIKit

class QuestionViewModal {
    
    weak var service: QuestionsServiceProtocol?
    
    var onErrorHandling : ((String?) -> Void)?
    var onSuccess : ((Any?) -> Void)?
    
    init(service: QuestionsServiceProtocol = FileDataService.shared) { // change to API Call Service if necessary
        self.service = service
    }
    
    //MARK:- submitQuestions
    
    func submitQuestions(category : String? , selectedOptions : [Int]?){
        
        guard let service = service else {
            onErrorHandling?(StaticString.missingService)
            return
        }
        
        service.request(with: APIEndpoint.submitQuestions(category: category, selectedOption: selectedOptions)) {[weak self] (response) in
            
            switch response {
            case .success(let data):
                self?.onSuccess?(data)
                
            case .failure(let error):
                self?.onErrorHandling?(error.localizedDescription)
            }
        }
    }
}
