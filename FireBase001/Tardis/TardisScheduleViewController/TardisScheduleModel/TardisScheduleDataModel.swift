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
                self.listSchedules = listSchedule.sorted(by: { (a, b) -> Bool in
                    let dateA = CommonFunction.getDate(fromDateString: "\(a.startDay)", withFormat: "dd/MM/yyyy")
                    let dateB = CommonFunction.getDate(fromDateString: "\(b.startDay)", withFormat: "dd/MM/yyyy")
                    let intervalA = dateA.timeIntervalSince1970
                    let intervalB = dateB.timeIntervalSince1970
                    return intervalA < intervalB
                })
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    
    func firObserveSchedule(completionBlock: @escaping (Bool)-> Void) {
        self.listSchedules.removeAll()
        requestModel.firObserveValue { (status, listSchedule) in
            if status {
                self.listSchedules = listSchedule
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    func deleteSchedule(schedule: TardisScheduleObject, completionBlock: @escaping (Bool)->Void) {
        requestModel.delete(object: schedule) { (status) in
            if status {
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    func reset() {
        listSchedules.removeAll()
        requestModel.removeAllObserver()
    }
}
