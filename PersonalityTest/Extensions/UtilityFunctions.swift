//
//  UtilityFunctions.swift
//  PersonalityTest
//
//  Created by Taran on 17/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import UIKit
import AVFoundation

class UtilityFunctions {
    
    // alert view controller
    
    static let shared = UtilityFunctions()
    
    func show(alert title:String? , message:String?  , buttonOk: @escaping () -> () , viewController: UIViewController , buttonTextOK: String?, buttonTextCancel: String? , buttonCancel: (() -> ())?  ){
        
        let alertController = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: buttonTextOK , style: UIAlertAction.Style.cancel, handler: {  (action) in
            buttonOk()
        }))
        
        if buttonTextCancel != nil {
            alertController.addAction(UIAlertAction(title: buttonTextCancel , style: UIAlertAction.Style.destructive, handler: {  (action) in
                buttonCancel?()
            }))
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
}
