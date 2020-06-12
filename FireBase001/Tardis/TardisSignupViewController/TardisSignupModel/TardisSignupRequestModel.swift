//
//  TardisSignupRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 6/3/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase

class TardisSignupRequestModel: NSObject {
    static let shared = TardisSignupRequestModel()
    
    var firRef: DatabaseReference
    override init() {
        self.firRef = TardisModel.shared.firRef.child("Users")
    }
    
    func registerNewUserWithMail( username: String,
                                  password: String,
                                  completionBlock: @escaping (Bool)->Void) {
        Auth.auth().createUser(withEmail: username, password: password) { (user, err) in
            if let error = err {
                print(error)
                CommonFunction.annoucement(title: "", message: "Có lỗi trong quá trình đăng ký")
                completionBlock(false)
            }
            // Register Success
            let userInfo = ["username":username ,
                            "password":password]
            self.updateUser(userInfo: userInfo) { (status) in
                completionBlock(status)
            }
        }
    }
    
    func updateUser(userInfo: Dictionary<String,Any>,completionBlock: @escaping (Bool)->Void) {
        firRef.updateChildValues(userInfo) { (err, ref) in
            if let errMess = err {
                print(errMess)
                CommonFunction.annoucement(title: "", message: "Có lỗi trong quá trình thêm thông tin user")
                return
            }
            CommonFunction.annoucement(title: "", message: "Thành công")
        }
    }
}
