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
    var firRef: DatabaseReference?
    override init() {
        super.init()
        firRef = TardisBaseRequestModel.shared.firRef.child("Activities")
    }
    
    func addActivity(activity: TardisActivityObject, completionBlock: @escaping (Bool)->Void) {
        guard let firRef = self.firRef else {return}
        CommonFunction.showLoadingView()
        firRef.child(UserInfo.getUID()).childByAutoId().setValue(activity.toJSON()) { (err, ref) in
            CommonFunction.hideLoadingView()
            if err != nil {
                completionBlock(false)
                return
            }
            completionBlock(true)
        }
    }
    
    func loadActivity(completionBlock: @escaping (Bool,[TardisActivityObject])->Void) {
        guard let firRef = self.firRef else {return}
        CommonFunction.showLoadingView()
        firRef.child(UserInfo.getUID()).observe(.value) { (snapShot) in
            let arrayActivity = [TardisActivityObject].init(JSONArray: snapShot)
        }
    }
}
