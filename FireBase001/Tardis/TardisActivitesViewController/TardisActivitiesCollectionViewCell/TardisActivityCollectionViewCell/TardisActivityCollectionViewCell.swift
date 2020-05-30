//
//  TardisActivityCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 5/24/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisActivityCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlet
    @IBOutlet weak var containerView: TardisView!
    @IBOutlet weak var headerView: TardisView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //Func
    func bindData(data: TardisActivity) {
        let startTime = CommonFunction.makeTimeStringFromFloat(time: data.startTime)
        let endTime = CommonFunction.makeTimeStringFromFloat(time: data.endTime)
        self.titleLabel.text = "\(data.activityName) \(startTime)-\(endTime)"
        self.descriptionLabel.text = "\(data.note)"
        
    }

}
