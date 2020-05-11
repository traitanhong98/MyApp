//
//  BaseViewController.swift
//  Heya
//
//  Created by TrungNV on 10/7/19.
//  Copyright © 2019 TrungNV. All rights reserved.
//

import UIKit

class BaseTabViewController: UIViewController {
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
