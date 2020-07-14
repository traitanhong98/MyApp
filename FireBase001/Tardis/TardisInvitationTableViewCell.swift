//
//  TardisInvitationTableViewCell.swift
//  FireBase001
//
//  Created by Hoang on 7/7/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

protocol TardisInvitationTableViewCellDelegate: class  {
    func didAcceptInvitation(of user: UserInfoObject)
    func didRejectInvitation(of user: UserInfoObject)
}

class TardisInvitationTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImgView: TardisImageView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    var user = UserInfoObject()
    var friend = TardisFriendObject()
    weak var delegate: TardisInvitationTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindData(uid: String) {
        if uid.count == 0 {
            return
        }
        TardisBaseRequestModel.shared.getUser(UID: uid) { (status, user) in
            if status {
                self.user = user
                self.userNameLabel.text = user.displayName
                if user.imageUrl.count > 0 {
                    let url = URL(string: user.imageUrl)
                    CommonFunction.getData(from: url!, completion: { (data, res, err) in
                        if err != nil {
                            return
                        }
                        DispatchQueue.main.async {
                            self.avatarImgView.image = UIImage(data: data!)
                        }
                    })
                }
            } 
        }
    }
    
    @IBAction func showInfoAction(_ sender: Any) {
        if user.UID.count > 0 {
            let userPopup = TardisUserInfoPopup()
            userPopup.currentUser = user
            userPopup.show()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func acceptButton(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.didAcceptInvitation(of: user)
    }
    @IBAction func deleteButton(_ sender: Any) {
        guard let delegate = delegate else { return }
        delegate.didRejectInvitation(of: user)
    }
}
