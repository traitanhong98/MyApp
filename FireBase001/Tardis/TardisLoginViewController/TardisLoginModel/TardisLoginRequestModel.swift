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
        self.firRef = TardisModel.shared.firRef.child("users")
    }
    
    func login(username: String, password: String, completionBlock: ((Bool) -> Void)?) {
        Auth.auth().signIn(withEmail: username, password: password) { (user, error) in
            if let err = error {
                print(err)
                print(err.localizedDescription)
                CommonFunction.annoucement(title: "", message: "Đăng nhập thất bại")
                if let completionBlock = completionBlock {completionBlock(false)}
                return
            }
            CommonFunction.annoucement(title: "", message: "Đăng nhập thành công")
            if let completionBlock = completionBlock {completionBlock(true)}
        }
    }
}
