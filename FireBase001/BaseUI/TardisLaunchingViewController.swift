//
//  TardisLaunchingViewController.swift
//  FireBase001
//
//  Created by Hoang on 6/11/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Lottie
class TardisLaunchingViewController: UIViewController {
    // MARK: - IBOutlet
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        setupUI()
        animate()
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (timer) in
            self.setupRootVC()
        }
    }
    
    // MARK: - Func
    func setupUI() {
        let animationView = AnimationView(name: "14721-loading")
        animationView.frame.size = CGSize(width: 400, height: 400)
        animationView.center = CGPoint(x: self.view.frame.width / 2,
                                       y: self.view.frame.height / 4 * 3)
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 0.5
        
        view.addSubview(animationView)
        
        animationView.play()
    }
    func animate() {
    }
    @objc func setupRootVC() {
        let rootVC = TardisMainTabbarViewController()
        if let senceDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate{
            senceDelegate.window?.rootViewController = rootVC
            senceDelegate.window?.makeKeyAndVisible()
        }
    }
}
