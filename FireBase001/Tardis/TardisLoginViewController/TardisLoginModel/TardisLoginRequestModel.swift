//
//  TardisLoginRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 5/11/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
class TardisLoginRequestModel:NSObject {
    static let shared = TardisLoginRequestModel()
    
    var firRef: DatabaseReference
    override init() {
        self.firRef = TardisBaseRequestModel.shared.firRef.child("users")
    }
    
    func login(username: String, password: String, completionBlock: ((Bool) -> Void)?) {
        CommonFunction.showLoadingView()
        Auth.auth().signIn(withEmail: username, password: password) { (user, error) in
            CommonFunction.hideLoadingView()
            if let err = error {
                print(err)
                print(err.localizedDescription)
                if let completionBlock = completionBlock {completionBlock(false)}
                return
            }
            TardisBaseRequestModel.shared.getCurrentUserInfo()
            TardisBaseRequestModel.shared.updateUserLoginStatus(true)
            if let completionBlock = completionBlock {completionBlock(true)}
        }
    }
}
