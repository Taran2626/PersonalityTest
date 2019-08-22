//
//  PersonalityTestUITests.swift
//  PersonalityTestUITests
//
//  Created by Taran on 17/08/19.
//  Copyright © 2019 Taranjeet_MacBook. All rights reserved.
//

import XCTest
var app: XCUIApplication!

class PersonalityTestUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCategoryListLabels(){
        XCTAssertTrue(app.navigationBars["Category List"].exists)
        XCTAssertTrue(app.staticTexts["Select a category"].exists)
        
    }
    
    //tableIdentifier
    //categoryCellIdentifier
    
    func testTableInteraction() {
        
        app.launch()
        
        // Assert that we are displaying the tableview
        let categoriesTableView = app.tables["tableIdentifier"]
        
        XCTAssertTrue(categoriesTableView.exists, "The categories tableview exists")
        
        // Get an array of cells
        let tableCells = categoriesTableView.cells
        
        if tableCells.count > 0 {
            let count: Int = (tableCells.count - 1)
            
            let promise = expectation(description: "Wait for table cells")
            
            for i in stride(from: 0, to: count , by: 1) {
                // Grab the first cell and verify that it exists and tap it
                let tableCell = tableCells.element(boundBy: i)
                XCTAssertTrue(tableCell.exists, "The \(i) cell is in place on the table")
                // Does this actually take us to the next screen
                tableCell.tap()
                
                if i == (count - 1) {
                    promise.fulfill()
                }
                // Back
                app.navigationBars.buttons.element(boundBy: 0).tap()
            }
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
            
        }
        
    }
    
    func testSubmitQuestion(){
        
        let categoriesTableView = app.tables["tableIdentifier"]
        
        let firstCell = categoriesTableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
        firstCell.tap()
        
        let tablesQuery2 = app.tables
        let firstCell_table2 = tablesQuery2.cells.element(boundBy: 0)
        
        let nextButton = app.buttons["Next"]
        let submitButton = app.buttons["Submit"]
        
        for _ in 0...4 {
            
            XCTAssertTrue(firstCell_table2.exists)
            firstCell_table2.tap()
            
            if submitButton.exists{
                submitButton.tap()
            }else{
                nextButton.tap()
            }
        }
        
        app.alerts["Success"].buttons["Ok"].tap()
        
    }
    
}


