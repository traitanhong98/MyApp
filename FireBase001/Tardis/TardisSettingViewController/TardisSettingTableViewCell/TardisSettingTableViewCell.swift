//
//  TardisSettingTableViewCell.swift
//  FireBase001
//
//  Created by Hoang on 5/26/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisSettingTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var mainSettingViewCell: TardisView!
    
    @IBOutlet weak var settingIcon: UIImageView!
    // MARK: - Propeties
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }
    // MARK: - Func
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        mainSettingViewCell.createShadow()
    }
    func bindData(setting: Setting) {
        settingIcon.image = setting.image
    }
}
