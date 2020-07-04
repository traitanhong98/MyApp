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
    @IBOutlet weak var timeLabel: UILabel!
    //MARK: - Propeties
    //MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    override func prepareForReuse() {
        containerView.backgroundColor = UIColor(red: 0.000, green: 0.478, blue: 1.000, alpha: 1)
        containerView.alpha = 0.25
    }
    //MARK: - Func
    func bindData(data: TardisActivityObject,sizeRatio: Float, indexPath: IndexPath, viewMode: ViewMode) {
        self.titleLabel.text = "\(data.activityName)"
        timeLabel.text = "\(data.startTime) - \(data.endTime)"
        headerView.isHidden = viewMode == .dayHour
        timeLabel.isHidden = viewMode == .dayHour
        if viewMode == .dayHour {
            containerView.backgroundColor = Weekday.allWeekdays[(indexPath.section - 1) % 7].weekColor
            containerView.alpha = 0.75
        }
    }
    
    func setupUI() {
    }
    
}
