//
//  TardisPopup.swift
//  FireBase001
//
//  Created by Hoang on 6/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

protocol TardisPopupDelegate:class {
    func acceptAction()
    func backAction()
}

class TardisPopup: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var backButton: TardisButton!
    @IBOutlet weak var acceptButton: TardisButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - Propety
    weak var delegate: TardisPopupDelegate?
    var titleString = ""
    var descriptionString = ""
    var isAccept = true
    var isBack = true
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = titleString
        descriptionLabel.text = descriptionString
        acceptButton.isHidden = !isAccept
        backButton.isHidden = !isBack
    }
    
    func settingPoup(title: String,description: String,isAcceptButton: Bool, isBackButton: Bool) {
        titleString = title
        descriptionString = description
        isAccept = isAcceptButton
        isBack = isBackButton
    }
    func show() {
        self.view.frame = CommonFunction.rootVC.view.frame
        self.view.isUserInteractionEnabled = true
        CommonFunction.rootVC.addChild(self)
        CommonFunction.rootVC.view.addSubview(self.view)
        CommonFunction.rootVC.view.bringSubviewToFront(self.view)
        let originFrame = popupView.frame
        popupView.frame = .init(x: originFrame.origin.x,
                                y: originFrame.origin.y + 150,
                                width: originFrame.width,
                                height: originFrame.height)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.popupView.frame = originFrame
        }, completion: nil)
        self.view.layoutIfNeeded()
    }
    func hide() {
        let alterFrame = CGRect(x: popupView.frame.origin.x,
                                y: popupView.frame.origin.y + 150,
                                width: popupView.frame.width,
                                height: popupView.frame.height)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.popupView.frame = alterFrame
        }, completion: { result in
            self.removeFromParent()
            self.view.removeFromSuperview()
        })
    }
    
    @IBAction func closePopup(_ sender: Any) {
        self.hide()
    }
    
    @IBAction func acceptAction(_ sender: Any) {
        self.hide()
        if let delegate = self.delegate {
            delegate.acceptAction()
        }
    }
    @IBAction func backAction(_ sender: Any) {
        self.hide()
        if let delegate = self.delegate {
            delegate.backAction()
        }
    }
}
