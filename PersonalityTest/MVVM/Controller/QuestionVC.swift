//
//  QuestionVC.swift
//  PersonalityTest
//
//  Created by Taran on 18/08/19.
//  Copyright © 2019 Taranjeet_MacBook. All rights reserved.
//

import UIKit

class QuestionVC: BaseVC {
    
    //MARK:- Outlets
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    
    //MARK:- Custom Properties
    var questionArray : [Questions]?
    var currentIndex = 0
    lazy var viewModel = QuestionViewModal()
    
    //MARK:- dataSource
    var dataSource = TableViewDataSource(){
        didSet{
            tableView.dataSource = dataSource
            tableView.delegate = dataSource
        }
    }
    
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableview()
        setupData()
        
        viewModel.onErrorHandling = {error in
            
            UtilityFunctions.shared.show(alert: StaticString.opps, message: error , buttonOk: {
            }, viewController: self, buttonTextOK: StaticString.ok, buttonTextCancel: StaticString.retry, buttonCancel:{[unowned self] in
                self.actionBtnSubmit(self.btnSubmit)
            })
        }
        
        viewModel.onSuccess = {value in
            UtilityFunctions.shared.show(alert: StaticString.success , message: StaticString.questionSubitMsg, buttonOk: {[weak self] in
                _ = self?.questionArray?.map({$0.questionType?.selectedAnswer = nil})
                self?.navigationController?.popViewController(animated: true)
                }, viewController: self, buttonTextOK: StaticString.ok , buttonTextCancel: nil, buttonCancel: nil)
            
        }
    }
}

//MARK:- setupUI elements
extension QuestionVC{
    
    func reloadData(isNext : Bool){
        currentIndex = isNext ? currentIndex + 1 : currentIndex - 1
        if currentIndex < /questionArray?.count{
            dataSource.items = questionArray?[currentIndex].questionType?.options
            tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            btnPrevious.isEnabled = currentIndex != 0
            setupData()
        }
    }
    
    func setNavAttempsTitle(){
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(currentIndex+1)/" + "\(/questionArray?.count)" , style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = "itemLabel"
        checkIfQuestionAnswered()
    }
    
    func setupData(){
        lblQuestion?.text = "Q\(currentIndex + 1) : " + "\(/questionArray?[currentIndex].question)"
        navigationItem.title = /questionArray?[currentIndex].category?.capitalized
        setNavAttempsTitle()
        
    }
    
    func checkIfQuestionAnswered(){
        btnNext.isEnabled = questionArray?[currentIndex].questionType?.selectedAnswer != nil && currentIndex != (/questionArray?.count - 1)
        self.btnSubmit.isHidden = !(questionArray?[currentIndex].questionType?.selectedAnswer != nil && currentIndex == (/questionArray?.count - 1))
    }
}

//MARK:- setupTableview
extension QuestionVC {
    
    func setupTableview(){
        dataSource = TableViewDataSource(items: questionArray?[currentIndex].questionType?.options , height: UITableView.automaticDimension, tableView: tableView, cellIdentifier: .QuestionCell)
        
        dataSource.configureCellBlock = {(cell,item,indexPath) in
            (cell as? QuestionCell)?.lblOption?.text = (item as? String)?.capitalized
            (cell as? QuestionCell)?.accessoryType = indexPath.row == self.questionArray?[self.currentIndex].questionType?.selectedAnswer ? .checkmark : .none
            
        }
        
        dataSource.aRowSelectedListener = {[unowned self](indexPath) in
            self.questionArray?[self.currentIndex].questionType?.selectedAnswer = indexPath.row
            self.dataSource.items = self.questionArray?[self.currentIndex].questionType?.options
            self.tableView.reloadData()
            self.checkIfQuestionAnswered()
            
        }
        
    }
    
}

//MARK:- IBAction

extension QuestionVC {
    
    @IBAction func actionBtnPrevious(_ sender: Any) {
        reloadData(isNext: false)
    }
    
    @IBAction func actionBtnNext(_ sender: Any) {
        reloadData(isNext: true)
    }
    
    @IBAction func actionBtnSubmit(_ sender: UIButton) {
        let selectedIndex = questionArray?.map({/$0.questionType?.selectedAnswer})
        viewModel.submitQuestions(category: questionArray?[currentIndex - 1].category, selectedOptions: selectedIndex)
    }
}
