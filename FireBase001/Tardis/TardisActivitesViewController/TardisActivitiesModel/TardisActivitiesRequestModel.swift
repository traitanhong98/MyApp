//
//  TardisActivitiesRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 6/12/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase

class TardisActivitiesRequestModel: NSObject {
    var firRef = TardisBaseRequestModel.shared.firRef.child("Activities")
    
    func addActivity(activity: TardisActivityObject, completionBlock: @escaping (Bool)->Void) {
        CommonFunction.showLoadingView()
        var newChild = firRef.child(UserInfo.getUID())
        
        if activity.id.count > 0 {
            newChild = newChild.child(activity.id)
        } else {
            newChild = newChild.childByAutoId()
        }
        let key = newChild.key ?? ""
        newChild.setValue(activity.toJSON()) { (err, ref) in
            CommonFunction.hideLoadingView()
            if err != nil {
                completionBlock(false)
                return
            }
            activity.id = key
            completionBlock(true)
        }
    }
    
    func observeActivities(completionBlock: @escaping (Bool,[TardisActivityObject])->Void) {
        firRef.child(UserInfo.getUID()).observe(.value) { (snapShot) in
            var arrayActivities = [TardisActivityObject]()
            CommonFunction.hideLoadingView()
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
                guard let activity = TardisActivityObject.init(JSON: value) else {
                    completionBlock(false,[])
                    return
                }
                activity.id = key
                arrayActivities.append(activity)
            }
            completionBlock(true,arrayActivities)
        }
    }
    
    func removeActivityObserver() {
        firRef.removeAllObservers()
    }
}
