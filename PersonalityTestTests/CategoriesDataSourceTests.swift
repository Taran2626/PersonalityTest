//
//  CategoriesDataSourceTests.swift
//  PersonalityTestTests
//
//  Created by Taran on 21/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import XCTest
@testable import PersonalityTest

class CategoriesDataSourceTests: XCTestCase {
    
    var dataSource : TableViewDataSource!
    
    override func setUp() {
        super.setUp()
        dataSource = TableViewDataSource()
    }
    
    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }
    
    func testEmptyValueInDataSource() {
        
        // giving empty data value
        dataSource.items = []
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        
        // expected zero cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
    }
    
    func testValueInDataSource() {
        
        // giving data value
        let modal1 = QuestionModal(categories: ["A","B"], questions: [Questions(question: "Ques", category: "A", questionType: QuestionType(type: "A", options: ["a","b","c"], selectedAnswer: nil)), Questions(question: "Ques", category: "B", questionType: QuestionType(type: "A", options: ["a","b"], selectedAnswer: nil))])
        
        let modal2 = QuestionModal(categories: ["A"], questions: [Questions(question: "Ques", category: "A", questionType: QuestionType(type: "A", options: ["a","b","c"], selectedAnswer: nil))])
        
        dataSource.items = [modal1, modal2]
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        
        // expected two cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
    }
    
    func testValueCell() {
        
        // giving data value
        let modal = QuestionModal(categories: ["A"], questions: [Questions(question: "Ques", category: "A", questionType: QuestionType(type: "A", options: ["a","b","c"], selectedAnswer: nil))])
        dataSource.items = [modal]
        dataSource.cellIdentifier = "CategoryListCell"
    
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(CategoryListCell.self, forCellReuseIdentifier: "CategoryListCell")
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        // expected CategoryListCell class
        guard let _ = dataSource.tableView(tableView, cellForRowAt: indexPath) as? CategoryListCell else {
            XCTAssert(false, "Expected CategoryListCell class")
            return
        }        
    }
}
