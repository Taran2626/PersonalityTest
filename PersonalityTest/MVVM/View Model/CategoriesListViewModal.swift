//
//  ContactDetailViewModel.swift
//  PersonalityTest
//
//  Created by Taran  on 23/06/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import Foundation
import UIKit

protocol CategoryListener: class {
    func reloadData(value :Any?)
    func showErrorMessage(error :String?)
}

class CategoriesListViewModal {
    
    weak var delegate: CategoryListener?
    
    //MARK:- getQuestionsList
    
    func getQuestionsList(){
        
        APIManager.shared.request(with: APIEndpoint.getQuestions) {[weak self] (response) in
            switch response {
            case .success(let list):
                guard let arrayTemp = list as? QuestionModal else {return}
                self?.delegate?.reloadData(value: arrayTemp)
            case .failure(let error):
                self?.delegate?.showErrorMessage(error: error.localizedDescription)
                
            }
            
        }
        
    }
    
}


