//
//  TardisUserInfoTableViewCell.swift
//  FireBase001
//
//  Created by Hoang on 5/26/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisUserInfoTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var userAvatarImageView: TardisImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userStatusLabel: UILabel!
    // MARK: - Propeties
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK: - Func
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
