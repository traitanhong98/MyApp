//
//  TardisChannelTableViewCell.swift
//  FireBase001
//
//  Created by Hoang on 7/4/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit


class TardisChannelTableViewCell: UITableViewCell {

    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var channelNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        noticeView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bindData(channel: TardisChannelObject) {
        channelNameLabel.text = channel.channelName
    }
    
    func bindStatus(isNews: Bool) {
        noticeView.isHidden = !isNews
    }
}
