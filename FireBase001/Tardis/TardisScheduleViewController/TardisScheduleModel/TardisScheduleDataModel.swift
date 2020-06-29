//
//  TardisScheduleDataModel.swift
//  FireBase001
//
//  Created by Hoang on 6/25/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisScheduleDataModel: NSObject {

    static let shared = TardisScheduleDataModel()
    
    var selfView: TardisScheduleViewController?
    var requestModel = TardisScheduleRequestModel()
    var listSchedules = [TardisScheduleObject]()
    
    override init() {
        super.init()
    }
    
    func addSchedule(schedule: TardisScheduleObject, completionBlock: @escaping (Bool)->Void) {
        requestModel.addSchedule(schedule: schedule) { (status, schedule) in
            if status {
                self.listSchedules.append(schedule)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    func loadSchedule( completionBlock: @escaping (Bool)-> Void ) {
        requestModel.loadSchedule { (status, listSchedule) in
            if status {
                self.listSchedules.removeAll()
                self.listSchedules = listSchedule
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
}
