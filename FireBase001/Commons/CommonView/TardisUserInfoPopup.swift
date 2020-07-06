//
//  TardisUserInfoPopup.swift
//  FireBase001
//
//  Created by Hoang on 7/6/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
protocol TardisUserInfoPopupDelegate: class {
    func addFriend(user: UserInfoObject)
}

class TardisUserInfoPopup: TardisBasePopupViewController {

    @IBOutlet weak var avatarImg: TardisImageView!
    @IBOutlet weak var addFriendButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var containerView: TardisView!
    
    var isAllowInvite = true
    weak var delegate: TardisUserInfoPopupDelegate?
    var currentUser = UserInfoObject()
    override func viewDidLoad() {
        super.viewDidLoad()
        chatButton.isHidden = true
        animateView = containerView
        addFriendButton.isHidden = !isAllowInvite
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        userNameLabel.text = currentUser.displayName
        emailLabel.text = currentUser.email
        if currentUser.imageUrl.count > 0 {
            let url = URL(string: currentUser.imageUrl)
            CommonFunction.getData(from: url!, completion: { (data, res, err) in
                if err != nil {
                    return
                }
                DispatchQueue.main.async {
                    self.avatarImg.image = UIImage(data: data!)
                }
            })
        }
    }
    @IBAction func mapButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func addFriendAction(_ sender: Any) {
        guard let delegate = delegate else {
            return
        }
        delegate.addFriend(user: currentUser)
    }
    @IBAction func closeAction(_ sender: Any) {
        hide()
    }
}
