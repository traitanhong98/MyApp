//
//  TardisNavigationController.swift
//  FireBase001
//
//  Created by Hoang on 7/7/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisNavigationController: UINavigationController {

    override init(rootViewController: UIViewController) {
       super.init(nibName: nil, bundle: nil)
       pushViewController(rootViewController, animated: false)
     }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.tintColor = .primary
        navigationBar.prefersLargeTitles = true
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.primary]
        navigationBar.largeTitleTextAttributes = navigationBar.titleTextAttributes
        
        toolbar.tintColor = .primary
        
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "BackButton.png"), for: .normal) // Image can be downloaded from here below link
        backbutton.setTitle("Trở lại", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
        backbutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
    }
    @objc func backAction() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
}

