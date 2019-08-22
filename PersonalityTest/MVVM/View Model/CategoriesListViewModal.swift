//
//  CategoriesListViewModal.swift
//  PersonalityTest
//
//  Created by Taran  on 17/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import Foundation
import UIKit

class CategoriesListViewModal {
    
    weak var service: QuestionsServiceProtocol?
    
    var onErrorHandling : ((String?) -> Void)?
    var onSuccess : ((Any?) -> Void)?
    
    init(service: QuestionsServiceProtocol = FileDataService.shared) { // change to API Call Service if necessary
        self.service = service
    }
    
    //MARK:- getQuestionsList
    
    func getQuestionsList(){
        
        guard let service = service else {
            onErrorHandling?(StaticString.missingService)
            return
        }
        
        service.request(with: APIEndpoint.getQuestions) {[weak self] (response) in
            switch response {
            case .success(let list):
                guard let arrayTemp = list as? QuestionModal else {return}
                self?.onSuccess?(arrayTemp)
            case .failure(let error):
                self?.onErrorHandling?(error.localizedDescription)
                
            }
            
        }
    }
    
}


