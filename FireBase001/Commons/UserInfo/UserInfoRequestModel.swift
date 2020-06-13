//
//  UserInfoRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 6/13/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase

class UserInfoRequestModel: NSObject {
    static let shared = UserInfoRequestModel()
    override init() {
        super.init()
    }
    
    func userDidLogin() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
}
