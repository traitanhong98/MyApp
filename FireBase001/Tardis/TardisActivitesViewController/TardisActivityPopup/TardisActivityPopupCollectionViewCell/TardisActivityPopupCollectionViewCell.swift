//
//  TardisActivityPopupCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 6/22/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
protocol  TardisActivityPopupCollectionViewCellDelegate: class{
    func didSelect(weekDay: Weekday,isChecked: Bool, completionBlock: @escaping (Bool) ->Void)
}
class TardisActivityPopupCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: TardisView!
    
    @IBOutlet weak var checkView: TardisView!
    @IBOutlet weak var weekdayLabel: UILabel!
    
    var isChecked = false {
        didSet {
            checkView.isHidden = !isChecked
            if isChecked {
                containerView.borderColor = weekDay?.weekColor ?? .blue
                weekdayLabel.textColor = .init(red: 0, green: 30/255, blue: 77/255, alpha: 1)
            } else {
                containerView.borderColor = .init(red: 0.342, green: 0.424, blue: 0.541, alpha: 1)
                weekdayLabel.textColor = .init(red: 0.342, green: 0.424, blue: 0.541, alpha: 1)
            }
        }
    }
    var isValid = true {
        didSet {
            if isValid {
                checkView.backgroundColor = .init(red: 0, green: 30/255, blue: 77/255, alpha: 1)
            } else {
                checkView.backgroundColor = .red
            }
        }
    }
    var weekDay: Weekday?
    weak var delegate: TardisActivityPopupCollectionViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
        checkView.isHidden = true    }
    func bindData(weekDay: Weekday) {
        weekdayLabel.text = weekDay.sortName
        containerView.borderColor = .init(red: 0.342, green: 0.424, blue: 0.541, alpha: 1)
        weekdayLabel.textColor = .init(red: 0.342, green: 0.424, blue: 0.541, alpha: 1)
        self.weekDay = weekDay
    }

    @IBAction func containerButtonTapped(_ sender: Any) {
        guard let delegate = delegate, let weekDay = weekDay else {return}
        isChecked = !isChecked
        delegate.didSelect(weekDay: weekDay, isChecked: isChecked) { status in
            self.isValid = status
        }
    }
}
