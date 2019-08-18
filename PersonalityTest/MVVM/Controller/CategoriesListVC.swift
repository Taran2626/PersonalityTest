//
//  CategoriesListVC.swift
//  PersonalityTest
//
//  Created by Taran  on 17/08/19.
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
        setupData()
    }
    
    //MARK:- setupData
    func setupData(){
        setupTableview()
        getQuestionsList()
    }
    
     func getQuestionsList(){
        viewModel.delegate = self
        viewModel.getQuestionsList()
    }
}

//MARK:- setupTableview
extension CategoriesListVC {
    
    func setupTableview(){
        dataSource = TableViewDataSource(items: questionModal?.categories , height: 56, tableView: tableView, cellIdentifier: .CategoryListCell)
        
        dataSource?.configureCellBlock = {(cell,item,indexPath) in
            (cell as? UITableViewCell)?.textLabel?.text = (item as? String)?.capitalized

        }
        
        dataSource?.aRowSelectedListener = {[unowned self](indexPath) in
            self.performSegue(withIdentifier: SegueString.segueContactDetails, sender: indexPath)
        }
        
    }
    
}

//MARK:- ContactApiListener

extension CategoriesListVC : CategoryListener {
    
    func reloadData(value :Any?){ // reload data to screen
        questionModal = value as? QuestionModal
        dataSource?.items = questionModal?.categories
        DispatchQueue.main.async {[weak self] in
            self?.dataSource?.tableView?.reloadData()
        }
    }
    
    
    func showErrorMessage(error :String?){ // show error message
        UtilityFunctions.show(alert: StaticString.opps, message: error , buttonOk: {
        }, viewController: self, buttonTextOK: StaticString.ok, buttonTextCancel: StaticString.retry, buttonCancel:{[weak self] in
            self?.getQuestionsList()
        })
        
    }
}

//MARK:- prepare for segue
extension CategoriesListVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
