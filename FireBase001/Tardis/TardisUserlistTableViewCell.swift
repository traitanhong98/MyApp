//
//  TardisUserlistTableViewCell.swift
//  FireBase001
//
//  Created by Hoang on 7/6/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisUserlistTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: TardisImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var statusView: TardisView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func bindData(user: UserInfoObject) {
        if user.imageUrl.count > 0 {
            let url = URL(string: user.imageUrl)
            CommonFunction.getData(from: url!, completion: { (data, res, err) in
                if err != nil {
                    return
                }
                DispatchQueue.main.async {
                    self.avatarImageView.image = UIImage(data: data!)
                }
            })
        }
        
        userNameLabel.text = user.displayName
        statusView.isHidden = !user.isLogin
    }
    
}
