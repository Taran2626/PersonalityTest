//
//  CategoriesServiceTests.swift
//  PersonalityTestTests
//
//  Created by Taran on 21/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import XCTest
@testable import PersonalityTest

class CategoriesServiceTests: XCTestCase {
    
    fileprivate var service : FileDataService!
    
    override func setUp() {
        super.setUp()
        self.service = FileDataService()
    }
    
    override func tearDown() {
        self.service = nil
        super.tearDown()
    }
    
    func testFileService(){
        
        let promise = expectation(description: "JSON fetched")
        
        service.request(with: APIEndpoint.getQuestions) {(response) in
            switch response {
            case .success(let value) :
                
                XCTAssertNotNil(value)
                promise.fulfill()
                
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
        
        waitForExpectations(timeout: 20) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testParserHandler(){
        
        let promise = expectation(description: "JSON to be parsed")
        
        // giving a sample json file
        guard let data = FileManager.readJson(forResource: "TestJson") else {
            XCTFail("error: No file or data")
            return
        }
        
        guard let _ = APIEndpoint.getQuestions.handle(data: data) as? QuestionModal else{
            XCTAssert(false, "Expected QuestionModal class")
            return
        }
        
        promise.fulfill()
        
        waitForExpectations(timeout: 20) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    
}

