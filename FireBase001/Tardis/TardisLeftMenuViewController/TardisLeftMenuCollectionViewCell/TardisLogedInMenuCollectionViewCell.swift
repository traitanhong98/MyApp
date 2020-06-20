//
//  TardisLogedInMenuCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 6/13/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
class TardisLogedInMenuCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarImgView: TardisImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func bindData(user: UserInfoObject) {
        if user.displayName.count > 0 {
            nameLabel.text = user.displayName
        } else {
            nameLabel.text = user.email
        }
    }

}
