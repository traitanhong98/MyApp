//
//  TardisUserInfoRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 6/19/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
import ObjectMapper
class TardisUserInfoRequestModel: NSObject {
    var firRef: DatabaseReference?
    var firStorageRef: StorageReference?
    override init() {
        firRef = TardisBaseRequestModel.shared.firRef.child("Users")
        firStorageRef = TardisBaseRequestModel.shared.firStorageRef.child("user_avatar")
    }
    
    func updateCurrentUserInfo(userInfo: UserInfoObject, completionBlock: @escaping((Bool)->Void)) {
        let userInfoDict = userInfo.toJSON()
        self.firRef?.child(UserInfo.getUID()).updateChildValues(userInfoDict, withCompletionBlock: { (err, ref) in
            if err != nil {
                completionBlock(false)
                return
            }
            completionBlock(true)
        })
    }
    func uploadUserAvatar(avatar: UIImage,completionBlock: @escaping (Bool,String)->Void) {
        if let imgData = avatar.jpegData(compressionQuality: 0.75) {
            let userAvatar = firStorageRef?.child(UserInfo.getUID())
            userAvatar?.putData(imgData, metadata: nil, completion: { (response, err) in
                if let error = err {
                    print("Error: Upload imageFail\(error.localizedDescription)")
                    completionBlock(false,"")
                    return
                }
                
                userAvatar?.downloadURL(completion: { (url, err) in
                    if let error = err {
                        print(print("Error: Download URL Fail \(error.localizedDescription)"))
                        completionBlock(false,"")
                        return
                    }
                    if let url = url {
                        completionBlock(true,url.absoluteString)
                    }
                })
            })
        }
        
    }
}
