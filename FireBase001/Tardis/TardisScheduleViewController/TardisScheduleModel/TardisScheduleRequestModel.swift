//
//  TardisScheduleRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 6/25/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
class TardisScheduleRequestModel: NSObject {
    var firRef = TardisBaseRequestModel.shared.firRef.child("Schedules")
    
    func addSchedule(schedule: TardisScheduleObject, completionBlock: @escaping (Bool,TardisScheduleObject)->Void) {
        CommonFunction.showLoadingView()
        var newChild = firRef.child(UserInfo.getUID())
        
        if schedule.id.count > 0 {
            newChild = newChild.child(schedule.id)
        } else {
            newChild = newChild.childByAutoId()
        }
        let key = newChild.key ?? ""
        newChild.setValue(schedule.toJSON()) { (err, ref) in
            CommonFunction.hideLoadingView()
            if err != nil {
                completionBlock(false,TardisScheduleObject())
                return
            }
            schedule.id = key
            completionBlock(true,schedule)
        }
    }
    func loadSchedule(completionBlock: @escaping (Bool,[TardisScheduleObject])->Void) {
        CommonFunction.showLoadingView()
        firRef.child(UserInfo.getUID()).observe(.value ,with: { (snapShot) in
            CommonFunction.hideLoadingView()
            var arraySchedules = [TardisScheduleObject]()
            for child in snapShot.children {
                guard let snap = child as? DataSnapshot else {
                    completionBlock(false,[])
                    return
                }
                let key = snap.key
                guard let value = snap.value as? [String:Any] else {
                    completionBlock(false,[])
                    return
                }
                guard let schedule = TardisScheduleObject.init(JSON: value) else {
                    completionBlock(false,[])
                    return
                }
                schedule.id = key
                arraySchedules.append(schedule)
            }
            completionBlock(true,arraySchedules)
        })
    }
    func firObserveValue(completionBlock: @escaping (Bool,[TardisScheduleObject])->Void) {
        CommonFunction.showLoadingView()
        firRef.child(UserInfo.getUID()).observe(.value) { (snapShot) in
            CommonFunction.hideLoadingView()
            var arraySchedules = [TardisScheduleObject]()
            for child in snapShot.children {
                guard let snap = child as? DataSnapshot else {
                    completionBlock(false,[])
                    return
                }
                let key = snap.key
                guard let value = snap.value as? [String:Any] else {
                    completionBlock(false,[])
                    return
                }
                guard let schedule = TardisScheduleObject.init(JSON: value) else {
                    completionBlock(false,[])
                    return
                }
                schedule.id = key
                arraySchedules.append(schedule)
            }
            completionBlock(true,arraySchedules)
        }
    }
    func delete(object: TardisScheduleObject, completionBlock: @escaping (Bool) -> Void) {
        CommonFunction.showLoadingView()
        firRef.child(UserInfo.getUID()).child(object.id).removeValue { (err, ref) in
            CommonFunction.hideLoadingView()
            if err != nil {
                completionBlock(false)
                return
            }
            completionBlock(true)
        }
    }
    
    func removeAllObserver() {
        firRef.removeAllObservers()
    }
}
