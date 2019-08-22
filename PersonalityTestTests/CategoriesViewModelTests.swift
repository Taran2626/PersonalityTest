//
//  CategoriesViewModelTests.swift
//  PersonalityTestTests
//
//  Created by Taran on 21/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import XCTest
@testable import PersonalityTest

class CategoriesViewModelTests: XCTestCase {

    var viewModel : CategoriesListViewModal!
    fileprivate var service : MockCategoryService!
    
    override func setUp() {
        super.setUp()
        self.service = MockCategoryService()
        self.viewModel = CategoriesListViewModal(service: service)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.service = nil
        super.tearDown()
    }
    
    func testFetchWithNoService() {
        
        let expectation = XCTestExpectation(description: "No service category")
        
        // giving no service to a view model
        viewModel.service = nil
        
        // expected to not be able to fetch categories
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.getQuestionsList()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchCategories() {
        
        let expectation = XCTestExpectation(description: "Category fetch")
        
        // giving a service mocking categories
        service.modal = QuestionModal(categories: ["A"], questions: [Questions(question: "Ques", category: "A", questionType: QuestionType(type: "A", options: ["a","b","c"], selectedAnswer: nil))])
        
        viewModel.onErrorHandling = { _ in
            XCTAssert(false, "ViewModel should not be able to fetch without service")
        }
        
        viewModel.onSuccess = { _ in
            expectation.fulfill()
        }
        
        viewModel.getQuestionsList()
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchNoCategories() {
        
        let expectation = XCTestExpectation(description: "No category")
        
        // giving a service mocking error during fetching categories
        service.modal = nil
        
        // expected completion to fail
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.getQuestionsList()
        wait(for: [expectation], timeout: 5.0)
    }
}

fileprivate class MockCategoryService : QuestionsServiceProtocol {
    
    var modal : QuestionModal?
    
    func request(with api : Router , completion : @escaping (Result<Any?,Error>) -> ()){
    
        if let modal = modal {
            completion(Result.success(modal))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No category")))
        }
    }
}


