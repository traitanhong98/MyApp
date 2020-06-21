//
//  TardisCommonMenuCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 6/13/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisCommonMenuCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var settingLabel: UILabel!
    
    @IBOutlet weak var settingImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindData(setting: Setting) {
        settingImageView.image = setting.image
        settingLabel.text = setting.name
    }
}
