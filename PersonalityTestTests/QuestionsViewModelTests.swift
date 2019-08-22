//
//  QuestionsViewModelTests.swift
//  PersonalityTestTests
//
//  Created by Taran on 22/08/19.
//  Copyright © 2019 Taranjeet_MacBook. All rights reserved.
//

import XCTest
@testable import PersonalityTest

class QuestionsViewModelTests: XCTestCase {

    var viewModel : QuestionViewModal!
    fileprivate var service : MockCategoryService!
    
    override func setUp() {
        super.setUp()
        self.service = MockCategoryService()
        self.viewModel = QuestionViewModal(service: service)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.service = nil
        super.tearDown()
    }
    
    func testSubmitWithNoService() {
        
        let expectation = XCTestExpectation(description: "No service provided")
        
        // giving no service to a view model
        viewModel.service = nil
        
        // expected to not be able to submit questions
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.submitQuestions(category: "A", selectedOptions: [1])
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSubmitQuestions() {
        
        let expectation = XCTestExpectation(description: "Submit Answers to Questions")
        
        // giving a service mocking questions
        service.modal = [Questions(question: "Ques", category: "A", questionType: QuestionType(type: "A", options: ["a","b","c"], selectedAnswer: 2))]
        
        viewModel.onErrorHandling = { _ in
            XCTAssert(false, "ViewModel should not be able to submit without service")
        }
        
        viewModel.onSuccess = { _ in
            expectation.fulfill()
        }
        
        viewModel.submitQuestions(category: "A", selectedOptions: [1])
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSubmitNoAnswers() {
        
        let expectation = XCTestExpectation(description: "No answer to submit")
        
        // giving a service mocking error during submitting questions
        service.modal = nil
        
        // expected completion to fail
        viewModel.onErrorHandling = { error in
            expectation.fulfill()
        }
        
        viewModel.submitQuestions(category: "A", selectedOptions: [])
        wait(for: [expectation], timeout: 5.0)
    }
}

fileprivate class MockCategoryService : QuestionsServiceProtocol {
    
    var modal : [Questions]?
    
    func request(with api : Router , completion : @escaping (Result<Any?,Error>) -> ()){
    
        if let modal = modal {
            completion(Result.success(modal))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No questions")))
        }
    }
}


