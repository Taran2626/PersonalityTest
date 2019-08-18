//
//  BaseVC.swift
//  DemoTest
//
//  Created by Taran  on 17/08/19.
//  Copyright © 2019 Macbook_Taranjeet. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    //MARK:- IBOutlet
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
    
    
    //MARK:- dataSource
    var dataSource: TableViewDataSource?{
        didSet{
            tableView.dataSource = dataSource
            tableView.delegate = dataSource
        }
    }
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
}
