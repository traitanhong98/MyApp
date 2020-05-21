//
//  TardisWeekdayCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 5/15/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisWeekdayCollectionViewCell: UICollectionViewCell {
    //MARK:- Outlet
    @IBOutlet weak var mainCellView: UIView!
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var weekdayLabel: UILabel!
    //MARK:- Propeties
    //MARK:- Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    //MARK:- Func
    func initView(){
        mainCellView.createShadow()
        containerScrollView.layer.borderWidth = 1
        containerScrollView.layer.borderColor = UIColor.blue.cgColor
        containerScrollView.layer.cornerRadius = 10
    }
    func bindData(weekDay: Weekday) {
        weekdayLabel.text = weekDay.rawValue
        weekdayLabel.textColor = Weekday.getWeekColor(weekday: weekDay)
    }
}
