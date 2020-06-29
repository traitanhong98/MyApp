//
//  TardisCalendarPickerDayCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 6/28/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisCalendarPickerDayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var holidayImgView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var lunarDayLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    
    var isChecked = false {
        didSet{
            checkImageView.isHidden = !isChecked
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindData(date: Date, weekDay: Weekday, isFromThisMonth: Bool) {
        dayLabel.text = CommonFunction.getDateString(fromDate: date, andFormat: "dd")
        let lunarDay = CommonFunction.getLunarDateString(fromDate: date, andFormat: "dd-MM")
        lunarDayLabel.text = String(lunarDay.prefix(5))
        
        if !isFromThisMonth {
            dayLabel.textColor = .gray
            lunarDayLabel.textColor = .gray
        } else if weekDay == .Sun || weekDay == .Sat {
            dayLabel.textColor = .blue
            lunarDayLabel.textColor = .blue
        } else {
            dayLabel.textColor = mainColor
            lunarDayLabel.textColor = mainColor
        }
        if LunarHoliday.getLunarHoliday(dayString: String(lunarDay.prefix(5))) != .none {
            holidayImgView.isHidden = false
        } else {
            holidayImgView.isHidden = true
        }
    }
}
