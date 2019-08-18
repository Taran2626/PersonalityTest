//
//  QuestionModal.swift
//  PersonalityTest
//
//  Created by Taran  on 17/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import UIKit

class QuestionModal: Decodable {
    var categories : [String]?
    var Questions : [Questions]?
    enum CodingKeys : String, CodingKey {
        case categories
        case Questions = "questions"
    }
}

class Questions : Decodable  {
    var question : String?
    var category : String?
    var questionType : QuestionType?
    enum CodingKeys : String, CodingKey {
        case question
        case category
        case questionType = "question_type"
    }
}

class QuestionType : Decodable{
    var type : String?
    var options : [String]?
}



