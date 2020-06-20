//
//  TardisBaseRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 6/19/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase

class TardisBaseRequestModel: NSObject {
    let baseUrl = "https://fir-001app.firebaseio.com/"
    static let shared = TardisBaseRequestModel()
    var firRef: DatabaseReference
    var firStorageRef: StorageReference
    override init() {
        firRef = Database.database().reference(fromURL: baseUrl)
        firStorageRef = Storage.storage().reference()
    }
    
    func getCurrentUserInfo() {
        firRef.child("Users").child(UserInfo.getUID()).observe(.value) { (data) in
            if let dataValue = data.value as? [String : AnyObject]{
                UserInfo.currentUser = UserInfoObject.init(JSON: dataValue)!
            }
                
        }
    }
}
