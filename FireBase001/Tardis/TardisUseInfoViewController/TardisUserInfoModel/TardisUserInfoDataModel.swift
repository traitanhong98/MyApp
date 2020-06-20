//
//  TardisUserInfoDataModel.swift
//  FireBase001
//
//  Created by Hoang on 6/19/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisUserInfoDataModel: NSObject {
    var selfView: TardisUserInfoViewController?
    var requestModel: TardisUserInfoRequestModel?
    var currentUserInfo = UserInfo.currentUser
    override init() {
        requestModel = TardisUserInfoRequestModel()
    }
    
    // MARK: - Request
    func updateCurrentUserInfo(userInfo: UserInfoObject, completionBlock: @escaping((Bool)->Void)) {
        guard let requestModel = self.requestModel else {
            return
        }
        requestModel.updateCurrentUserInfo(userInfo: userInfo, completionBlock: { (result) in
            if result {
                UserInfo.currentUser = userInfo
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        })
    }
    
    func updateCurrentUserInfo(userInfo: UserInfoObject,avatar: UIImage, completionBlock: @escaping (Bool)->Void) {
        guard let requestModel = self.requestModel else {
            return
        }
        requestModel.uploadUserAvatar(avatar: avatar) { (status, url) in
            if status {
                userInfo.imageUrl = url
                requestModel.updateCurrentUserInfo(userInfo: userInfo) { (status) in
                    if status {
                        completionBlock(true)
                    } else {
                        completionBlock(false)
                    }
                }
            } else {
                completionBlock(false)
            }
        }
    }
    
}
