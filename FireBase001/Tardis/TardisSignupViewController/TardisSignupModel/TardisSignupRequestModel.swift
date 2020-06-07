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
    
            //Update user value into a child
    //        let userFirRef = firRef.child("users")
    //        let value = ["name": "Hoang nm", "email":"myfirstemail@gmail.com"]
    //              userFirRef.updateChildValues(value) { (err, ref) in
    //                  if let errMess = err {
    //                      print("HelloSenpai: Error here\(errMess)")
    //                      return
    //                  }
    //
    //                  print("HelloSenpai:Update Success fully")
    //              }
    //        // Do any additional setup after loading the view.
    func udateUser(userInfo: Dictionary<String,Any>) {
        firRef.updateChildValues(userInfo) { (err, ref) in
            if let errMess = err {
                CommonFunction.annoucement(view: TardisMainTabbarViewController.viewOfMainTabbar!, title: "", message: "Có lỗi trong quá trình thêm thông tin user")
                return
            }
            CommonFunction.annoucement(view: TardisMainTabbarViewController.viewOfMainTabbar!, title: "", message: "Thành công")
        }
    }
}
