//
//  UserInfo.swift
//  FireBase001
//
//  Created by Hoang on 6/3/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    
    //Login
    static func setLogin() {
        UserDefaults.standard.set(true, forKey: "IS_LOGIN")
        UserDefaults.standard.synchronize()
    }
    
    static func getLogin() -> Bool{
        return UserDefaults.standard.bool(forKey: "IS_LOGIN")
    }
    //Username
    static func setUsername() {
        UserDefaults.standard.set(true, forKey: "USERNAME")
        UserDefaults.standard.synchronize()
    }
    
    static func getUsername() -> String{
        return UserDefaults.standard.string(forKey: "USERNAME") ?? ""
    }
    //Password
    static func setPassword() {
        UserDefaults.standard.set(true, forKey: "PASSWORD")
        UserDefaults.standard.synchronize()
    }
    
    static func getPassword() -> String{
        return UserDefaults.standard.string(forKey: "PASSWORD") ?? ""
    }
}
