//
//  TardisWeekdayButtonCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 5/15/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
protocol TardisWeekdayButtonCollectionViewCellDelegate {
    func onTapButton()
}
class TardisWeekdayButtonCollectionViewCell: UICollectionViewCell {
    //MARK:- Outlet
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var borderView: TardisView!
    //MARK:- Propeties
    var delegate: TardisWeekdayButtonCollectionViewCellDelegate? = nil
    //MARK:- Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //MARK:- Func
    func bindData(weekDay: Weekday) {
        weekdayLabel.text = weekDay.rawValue
        weekdayLabel.textColor = Weekday.getWeekColor(weekday: weekDay)
    }
    func setupUI(){
    }
    //MARK:- Delegate method

}
