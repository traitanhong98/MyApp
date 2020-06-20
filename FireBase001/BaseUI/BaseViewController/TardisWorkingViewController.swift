//
//  TardisWorkingViewController.swift
//  FireBase001
//
//  Created by Hoang on 6/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Lottie

class TardisWorkingViewController: BaseTabViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var workingLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var notificationView: TardisView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    // MARK: - Func
    
    // MARK: - IBAction
    @IBAction func leftMenuTouchUpInside(_ sender: Any) {
        CommonFunction.rootVC.showLeftViewAnimated()
    }
}
