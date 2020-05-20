//
//  TardisWeekdayCollectionViewCell.swift
//  FireBase001
//
//  Created by Hoang on 5/15/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisWeekdayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainCellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    func initView(){
        mainCellView.backgroundColor = UIColor.red
        mainCellView.createShadow()
    }
}
