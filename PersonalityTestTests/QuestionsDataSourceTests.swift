//
//  QuestionsDataSourceTests.swift
//  PersonalityTestTests
//
//  Created by Taran on 22/08/19.
//  Copyright © 2019 Taranjeet_MacBook. All rights reserved.
//

import XCTest
@testable import PersonalityTest

class QuestionsDataSourceTests: XCTestCase {
    
    var dataSource : TableViewDataSource!
    var systemUnderTest : QuestionVC!
    
    override func setUp() {
        super.setUp()
        systemUnderTest = QuestionVC()
        dataSource = systemUnderTest.dataSource
    }
    
    override func tearDown() {
        systemUnderTest = nil
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
        let option1 = "Option1"
        
        let option2 = "Option2"
        
        dataSource.items = [option1, option2]
        
        let tableView = UITableView()
        tableView.dataSource = dataSource
        
        // expected one section
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        
        // expected two cells
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 2, "Expected two cell in table view")
    }
    
    func testValueCell() {
        
        // giving data value
        let option1 = "Option1"

        dataSource.items = [option1]
        dataSource.cellIdentifier = "QuestionCell"
    
        let tableView = UITableView()
        tableView.dataSource = dataSource
        tableView.register(QuestionCell.self, forCellReuseIdentifier: "QuestionCell")
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        // expected QuestionCell class
        guard let _ = dataSource.tableView(tableView, cellForRowAt: indexPath) as? QuestionCell else {
            XCTAssert(false, "Expected QuestionCell class")
            return
        }        
    }
}
