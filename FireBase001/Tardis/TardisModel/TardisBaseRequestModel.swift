//
//  TardisBaseRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 6/19/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
import ObjectMapper

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
    func getUser(UID: String, completionBlock: @escaping(Bool, UserInfoObject) -> Void) {
        firRef.child("Users").child(UID).observeSingleEvent(of: .value) { (data) in
            if let dataValue = data.value as? [String : AnyObject]{
                if let user = UserInfoObject.init(JSON: dataValue) {
                    user.UID = UID
                    completionBlock(true, user)
                } else {
                    completionBlock(false, UserInfoObject())
                }
            }
        }
    }
    func doLogOut() {
        updateLoginTime()
        updateUserLoginStatus(false)
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
            return
        }
        UserInfo.currentUser = UserInfoObject()
        CommonFunction.rootVC.initTabbar()
        CommonFunction.annoucement(title: "", message: "Đăng xuất thành công")
    }
    func removeAllObserver() {
        firRef.removeAllObservers()
    }
    
    func getStringFromPath(_ path: String, completionBlock: @escaping (String) -> Void) {
        firRef.child(path).observeSingleEvent(of: .value) { (snapShot) in
            guard let value = snapShot.value as? String else {
                completionBlock("")
                return
            }
            completionBlock(value)
        }
    }
    func observeAllOtherUsers(completionBlock: @escaping (Bool,[UserInfoObject]) -> Void) {
        firRef.child("Users").observe(.value) { (snapShot) in
            var arrayActivities = [UserInfoObject]()
            CommonFunction.hideLoadingView()
            for child in snapShot.children {
                guard let snap = child as? DataSnapshot else {
                    completionBlock(false,[])
                    return
                }
                let key = snap.key
                if key == UserInfo.getUID() {
                    continue
                }
                guard let value = snap.value as? [String:Any] else {
                    completionBlock(false,[])
                    return
                }
                guard let activity = UserInfoObject.init(JSON: value) else {
                    completionBlock(false,[])
                    return
                }
                activity.UID = key
                arrayActivities.append(activity)
            }
            completionBlock(true,arrayActivities)
        }
    }
    func getListALLOtherUser(completionBlock: @escaping (Bool,[UserInfoObject]) -> Void) {
        firRef.child("Users").observeSingleEvent(of: .value) { (snapShot) in
            var arrayActivities = [UserInfoObject]()
            CommonFunction.hideLoadingView()
            for child in snapShot.children {
                guard let snap = child as? DataSnapshot else {
                    completionBlock(false,[])
                    return
                }
                let key = snap.key
                if key == UserInfo.getUID() {
                    continue
                }
                guard let value = snap.value as? [String:Any] else {
                    completionBlock(false,[])
                    return
                }
                guard let activity = UserInfoObject.init(JSON: value) else {
                    completionBlock(false,[])
                    return
                }
                activity.UID = key
                arrayActivities.append(activity)
            }
            completionBlock(true,arrayActivities)
        }
    }
    func updateUserLocation(_ location: Location) {
        firRef.child("Users").child(UserInfo.getUID()).child("location").setValue(location.toJSON())
    }
    func updateUserLoginStatus(_ status: Bool) {
        firRef.child("Users").child(UserInfo.getUID()).child("is_login").setValue(status)
    }
    func updateLoginTime() {
        firRef.child("Users").child(UserInfo.getUID()).child("last_online").setValue(Date().timeIntervalSince1970)
        
    }
    func getAllData<T:TardisBaseMapObject>(fromPath path: String, completionBlock: @escaping (Bool,[T]) -> Void) {
        firRef.child(path).observe(.value) { (snapShot) in
            var listResult = [T]()
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
                guard let object = T.init(JSON: value) else {
                    completionBlock(false,[])
                    return
                }
                
                object.id = key
                listResult.append(object)
            }
            completionBlock(true,listResult)
        }
    }
    
}
