//
//  TardisHourCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 5/30/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisHourCollectionViewCell: UICollectionViewCell {
    // MARK: - IBoutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var halfHourLabel: UILabel!
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK: - Func
    func bindData(hour: Int) {
        if hour == 24 {
            hourLabel.text = "00:00"
            halfHourLabel.text = "\(hour-1):30"
        } else if hour < 10 {
            hourLabel.text = "0\(hour):00"
            halfHourLabel.text = "0\(hour-1):30"
        } else {
            hourLabel.text = "\(hour):00"
            halfHourLabel.text = "\(hour-1):30"
        }
    }
}
