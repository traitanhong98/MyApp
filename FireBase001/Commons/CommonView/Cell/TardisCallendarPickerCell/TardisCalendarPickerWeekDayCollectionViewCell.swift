//
//  TardisCalendarPickerWeekDayCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 6/28/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisCalendarPickerWeekDayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var containerView: TardisView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindData(weekDay: Weekday) {
        weekDayLabel.text = weekDay.sortName
        if weekDay == .Sat || weekDay == .Sun {
            containerView.borderColor = .blue
            weekDayLabel.textColor = .blue
        } else {
            containerView.borderColor = mainColor
            weekDayLabel.textColor = mainColor
        }
    }
}
