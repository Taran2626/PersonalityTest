//
//  QuestionViewModal.swift
//  PersonalityTest
//
//  Created by Taran on 18/08/19.
//  Copyright © 2019 Taranjeet_MacBook. All rights reserved.
//

import UIKit

protocol QuestionViewModalListener: class {
    func reloadData(value :Any?)
    func showErrorMessage(error :String?)
}

class QuestionViewModal {
    
    weak var delegate: QuestionViewModalListener?
    
    //MARK:- submitQuestions
    
    func submitQuestions(category : String? , selectedOptions : [Int]?){
        
        APIManager.shared.request(with: APIEndpoint.submitQuestions(category: category, selectedOption: selectedOptions)) {[weak self] (response) in
            switch response {
            case .success(let data):
                self?.delegate?.reloadData(value: data)
            case .failure(let error):
                self?.delegate?.showErrorMessage(error: error.localizedDescription)
                
            }
            
        }
        
    }
    
}
