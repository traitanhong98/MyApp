//
//  UserInfo.swift
//  FireBase001
//
//  Created by Hoang on 6/3/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
class UserInfo: NSObject {
    
    static var currentUser = UserInfoObject()
    // MARK: - UID
    static func getUID() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    // MARK: - Login
    static func setLogin() {
        UserDefaults.standard.set(true, forKey: "IS_LOGIN")
        UserDefaults.standard.synchronize()
    }
    
    static func getLogin() -> Bool{
        return UserDefaults.standard.bool(forKey: "IS_LOGIN")
    }
    // MARK: - Username
    static func setUsername() {
        UserDefaults.standard.set(true, forKey: "USERNAME")
        UserDefaults.standard.synchronize()
    }
    
    static func getUsername() -> String{
        return UserDefaults.standard.string(forKey: "USERNAME") ?? ""
    }
    // MARK: - Password
    static func setPassword() {
        UserDefaults.standard.set(true, forKey: "PASSWORD")
        UserDefaults.standard.synchronize()
    }
    
    static func getPassword() -> String{
        return UserDefaults.standard.string(forKey: "PASSWORD") ?? ""
    }
    // MARK: - DidLogin
    static func userDidLogin() -> Bool{
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
    // MARK: - UserInfo
    static func getUserInfo() -> User? {
        if let user = Auth.auth().currentUser {
            return user
        } else {
            return nil
        }
    }
    // MARK: -
    // MARK: -
    // MARK: -
    // MARK: -
    // MARK: -
    // MARK: -
    // MARK: -
    // MARK: -
    // MARK: -
    // MARK: -
    // MARK: -
}
