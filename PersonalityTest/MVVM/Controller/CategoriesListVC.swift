//
//  CategoriesListVC.swift
//  PersonalityTest
//
//  Created by Taran on 17/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import UIKit


class CategoriesListVC: BaseVC {
    
    //MARK:- Custom Outlets
    lazy var viewModel = CategoriesListViewModal()
    var questionModal : QuestionModal?
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableview()
        setupData()
        
    }
    
    //MARK:- setupData
    func setupData(){
        
        viewModel.onErrorHandling = {error in
            
            UtilityFunctions.shared.show(alert: StaticString.opps, message: error , buttonOk: {
            }, viewController: self, buttonTextOK: StaticString.ok, buttonTextCancel: StaticString.retry, buttonCancel:{[weak self] in
                self?.viewModel.getQuestionsList()
            })
        }
        
        viewModel.onSuccess = {[weak self] value in
            self?.questionModal = value as? QuestionModal
            self?.dataSource?.items = self?.questionModal?.categories
            DispatchQueue.main.async {[weak self] in
                self?.dataSource?.tableView?.reloadData()
            }
        }
        
        viewModel.getQuestionsList()
    }

}

//MARK:- setupTableview
extension CategoriesListVC {
    
    func setupTableview(){
        dataSource = TableViewDataSource(items: questionModal?.categories , height: 56, tableView: tableView, cellIdentifier: .CategoryListCell)
        
        dataSource?.configureCellBlock = {(cell,item,indexPath) in
            (cell as? CategoryListCell)?.lblCategory?.text = (item as? String)?.capitalized
        }
        
        dataSource?.aRowSelectedListener = {[weak self](indexPath) in
            self?.performSegue(withIdentifier: SegueString.segueQuestions, sender: indexPath)
        }
        
    }
    
}

//MARK:- GetQuestions
extension CategoriesListVC {
    
    func getQuestions(index : Int)->[Questions]?{
        return questionModal?.Questions?.filter({$0.category == questionModal?.categories?[index]})
        
    }
}

//MARK:- Prepare for segue
extension CategoriesListVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as? QuestionVC)?.questionArray = getQuestions(index: /(sender as? IndexPath)?.row)
    }
}
