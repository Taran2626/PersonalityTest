//
//  QuestionModal.swift
//  PersonalityTest
//
//  Created by Taran on 17/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import UIKit

class QuestionModal: Decodable {
    var categories : [String]?
    var Questions : [Questions]?
    
    init(categories : [String]?, questions : [Questions]?) {
        self.categories = categories
        self.Questions = questions
    }
    
    enum CodingKeys : String, CodingKey {
        case categories
        case Questions = "questions"
    }
}

class Questions : Decodable  {
    var question : String?
    var category : String?
    var questionType : QuestionType?
    
    init(question : String?, category : String?, questionType : QuestionType?) {
        self.question = question
        self.category = category
        self.questionType = questionType
    }
    
    enum CodingKeys : String, CodingKey {
        case question
        case category
        case questionType = "question_type"
    }
}

class QuestionType : Decodable{
    var type : String?
    var options : [String]?
    var selectedAnswer : Int?
    
    init(type : String?, options : [String]?, selectedAnswer : Int?) {
        self.type = type
        self.options = options
        self.selectedAnswer = selectedAnswer
    }
}



