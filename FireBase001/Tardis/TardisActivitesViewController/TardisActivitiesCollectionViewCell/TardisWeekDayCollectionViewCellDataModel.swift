//
//  TardisWeekDayCollectionViewCellDataModel.swift
//  FireBase001
//
//  Created by Hoang on 6/6/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit



class TardisWeekDayCollectionViewCellDataModel: NSObject {
    var activities = [TardisActivityObject]()
    var viewMode = ViewMode.dayHour
    var sizeRatio: Float = 1
    
    override init() {
        super.init()
    }
    
    
    func calculatingHeightOfItem(startTime: String,endTime: String) -> Float{
        let start = CommonFunction.timeToFloat(time: startTime)
        let end = CommonFunction.timeToFloat(time: endTime)
        let heightResult = (end - start) * 60
        return heightResult
    }
    
    func activityCollectionView(_ collectionView: UICollectionView,referenceSizeForFooterInSection section: Int) -> CGSize {
        if activities.count == 0 {
            return .zero
        }
        if viewMode == .dayHour {
            let width = Float(collectionView.frame.width)
            var height: Float = 0
            if section == activities.count {
                height = calculatingHeightOfItem(startTime: activities[section - 1].endTime, endTime: "24:00")
            } else if section == 0 {
                height = calculatingHeightOfItem(startTime: "00:00", endTime: activities[0].startTime)
            } else {
                height = calculatingHeightOfItem(startTime: activities[section - 1].endTime, endTime: activities[section].startTime)
            }
            return CommonFunction.getSizeWithRatio(width: width,
                                                   height: height,
                                                   ratio: sizeRatio)
        } else {
            return CGSize(width: collectionView.frame.width,
                          height: 20)
        }
    }
}
