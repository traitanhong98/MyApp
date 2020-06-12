//
//  TardisSignupViewController.swift
//  FireBase001
//
//  Created by Hoang on 6/3/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisSignupViewController: UIViewController {
    // MARK: - IBOutlet
    
    // MARK: - Var
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Func
    func registerAction() {
        
    }
    // MARK: - IBAction
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonTouchUpInside(_ sender: Any) {
        self.registerAction()
    }
}
