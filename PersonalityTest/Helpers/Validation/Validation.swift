//
//  Validation.swift
//  PersonalityTest
//
//  Created by Taran  on 17/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import UIKit

enum Valid : Equatable{
    case success
    case failure(String)
}

class Validation: NSObject {
    
    static let shared = Validation()
    var errorMessage = ""
    
    func errorMsg(str : String) -> Valid{
        return .failure(str)
    }
    
    func isValidUpdateInfo(first:String? , last:String?,email : String?,mobile : String? , isImage : Bool ) -> Valid{
        if isValid(type: .firstName, info: first) &&  isValid(type: .lastName, info: last) && isValid(type: .mobile, info: mobile) &&  isValid(type: .email, info: email) &&  isValid(isImage: isImage){
            return .success
        }
        return errorMsg(str: errorMessage)
    }
    
    private func isValid(type : FieldType , info: String?) -> Bool {
        guard let validStatus = info?.handleStatus(fieldType : type) else {
            return true
        }
        errorMessage = validStatus
        return false
    }
    
    private func isValid(isImage: Bool) -> Bool {
        if isImage{
            return true
        }
        errorMessage = "Please select image"
        return false
    }
    
    
}


import UIKit

enum FieldType : String{
    
    case firstName = "first name"
    case lastName = "last name"
    case email = "Email"
    case mobile = "Mobile Number"
    
}

extension String {
    
    enum Status : String {
        
        case chooseEmpty = "Please choose "
        case empty = "Please enter "
        case allSpaces = " field should not be blank "
        case singleDot = "Only single period allowed for "
        case singleDash = "Only single dash allowed for "
        case singleSpace = "Only single space allowed for "
        case singleApostrophes = "Only single apostrophes allowed for "
        case valid
        case inValid = "Please enter valid "
        case allZeros = " Please enter valid "
        case hasSpecialCharacter = " must not contain special character"
        case notANumber = " must be a number"
        case passwrdLength = "Password length must be at least 6 characters long."
        case mobileNumberLength = "Phone number must be 5-15 digits."
        case passcodeNumberLength = "Passcode must be 4-6 digits."
        case emptyCountrCode = " Choose country code"
        case containsSpace = " field should not contain space"
        case containsAtTheRateCharacter = " field should not contain @ character"
        case minimumCharacters = " field should have atleast two characters"
        case minimumUsernameCharacters = " field should have atleast six characters"
        case passwordFormat = " field should have at least one lowercase letter, at least one uppercase letter, at least one special character, at least one digit and 6 - 20 characters"
        case usernameFormat = " field should have alphabetic characters, numeric characters, underscores, periods, and dashes only"
        case passwordValidation = " field should contain atleast 1 lowercase alphabet , 1 upper case alphabet and 1 digit"
        
        func message(type : FieldType) -> String? {
            
            switch self {
            case .hasSpecialCharacter , .allSpaces , .passwordFormat ,.usernameFormat : return type.rawValue.lowercased() + rawValue
            case .valid: return nil
            case .passwrdLength , .mobileNumberLength , .emptyCountrCode , .passcodeNumberLength : return  rawValue
            case .containsSpace: return type.rawValue.lowercased() + rawValue
            case .containsAtTheRateCharacter , .passwordValidation , .minimumCharacters , .minimumUsernameCharacters : return type.rawValue.lowercased() + rawValue
                //            case .singleDot , .singleDash , .singleSpace , .singleApostrophes : return rawValue
                
            default: return rawValue + type.rawValue.lowercased()
            }
        }
    }
    
    func handleStatus(fieldType : FieldType) -> String? {
        
        switch fieldType {
        case .firstName , .lastName :
            return  isValidName.message(type: fieldType)
        case .email :
            return  isValidEmail.message(type: fieldType)
        case .mobile :
            return  isValidPhoneNumber.message(type: fieldType)
            
            
        }
        
    }
    
    var isNumber : Bool {
        if let _ = NumberFormatter().number(from: self) {
            return true
        }
        return false
    }
    
    var hasSpecialCharcters : Bool {
        return rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil
    }
    
    var isEveryCharcterZero : Bool{
        var count = 0
        self.forEach {
            if $0 == "0"{
                count += 1
            }
        }
        if count == self.count{
            return true
        }else{
            return false
        }
    }
    
    public func toString(format: String , date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    public var length: Int {
        return self.count
    }
    
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    
    
    public var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty
        }
    }
    
    func isValid(password min: Int , max: Int) -> Status {
        if length <= 0 { return .empty }
        if isBlank  { return .empty  }
        //         if !checkPassword(text: self){ return .passwordValidation }
        //let isPasswordFormat = checkPassword(text: self)
        //if !isPasswordFormat { return .passwordFormat }
        if self.count >= min && self.count <= max { return .valid } else{
            return .passwrdLength
        }
        
    }
    
    
    func checkPassword(text : String?) -> Bool{
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).+$"
        let isMatched = NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: text)
        if isMatched{
            return true
        }else {
            return false
        }
    }
    
    func checkUsername(text : String?) -> Bool{
        let characterSet:  NSMutableCharacterSet = NSMutableCharacterSet.alphanumeric()
        characterSet.addCharacters(in: "_-.")
        let characterSetInverted:  NSMutableCharacterSet = characterSet.inverted as! NSMutableCharacterSet
        if text?.rangeOfCharacter(from: characterSetInverted as CharacterSet) != nil {
            return false
        }else {
            return true
        }
    }
    
    var isValidEmail : Status {
        if length <= 0 { return .empty }
        if isBlank { return .empty }
        if isEmail { return .valid }
        return .inValid
    }
    
   
    var isValidPhoneNumber : Status {
        if length < 0 { return .empty }
        if isBlank { return .empty }
        if isEveryCharcterZero { return .allZeros }
        if self.count >= 5 && self.count <= 15 { return .valid
        }else{
            return .mobileNumberLength
        }
    }
    
    
    var isValidName : Status {
        if length < 0 { return .empty }
        if isBlank { return .empty }
        return .valid
    }
}


//VALIDATION OF PAYMENT
enum Fields :String
{
    case name = "([A-Z][a-z]*)([\\s\\\'-][A-Z][a-z]*)*"
    case Email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    case cardNumber = "[0-9]"
    case cvv = "[0-9]{3}"
    
}
var count : Bool = false

public class FieldCheck
{
    static func validate(textValue:Fields, value : String) -> Bool
    {
        count = NSPredicate(format:"SELF MATCHES %@", textValue.rawValue).evaluate(with: value)
        return count
    }
}


