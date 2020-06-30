//
//  TardisBasePopupViewController.swift
//  FireBase001
//
//  Created by Hoang on 6/21/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisBasePopupViewController: UIViewController {

    var animateView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func show() {
        self.view.frame = CommonFunction.rootVC.view.frame
        self.view.isUserInteractionEnabled = true
        CommonFunction.rootVC.addChild(self)
        CommonFunction.rootVC.view.addSubview(self.view)
        if let animateView = animateView {
            let originFrame = animateView.frame
            animateView.frame = .init(x: originFrame.origin.x,
                                    y: originFrame.origin.y + 150,
                                    width: originFrame.width,
                                    height: originFrame.height)
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                animateView.frame = originFrame
            }, completion: nil)
        }
        self.view.layoutIfNeeded()
    }
    @objc func hide() {
        if let animateView = animateView {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
//                animateView.frame = .init(x: animateView.frame.origin.x,
//                                          y: animateView.frame.origin.y - 150,
//                                          width: animateView.frame.width,
//                                          height: animateView.frame.height)
                animateView.alpha = 0
            }, completion: { _ in
                animateView.isHidden = true
                self.view.removeFromSuperview()
                self.removeFromParent()
            })
        }
        
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
}
