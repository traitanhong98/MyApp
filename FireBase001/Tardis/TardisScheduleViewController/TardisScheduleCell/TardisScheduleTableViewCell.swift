//
//  TardisScheduleTableViewCell.swift
//  FireBase001
//
//  Created by Hoang on 6/25/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var expiredLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var schedule: TardisScheduleObject? {
        didSet{
            self.nameLabel.text = schedule?.name
            self.descriptionLabel.text = schedule?.des
            self.dateLabel.text = schedule!.startDay + " - " + schedule!.endDay
            self.timeLabel.text = schedule!.startTime + " - " + schedule!.endTime
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(schedule: TardisScheduleObject) {
        self.schedule = schedule
    }
}
