//
//  TardisChatRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 7/6/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase

class TardisChatRequestModel: NSObject {
    var friendListRef = TardisBaseRequestModel.shared.firRef.child("Friends")
    var chatRef = TardisBaseRequestModel.shared.firRef.child("Chats")
    
    
    func observeFriend(completionBlock: @escaping (Bool,[TardisFriendObject]) -> Void) {
        friendListRef.child(UserInfo.getUID()).observe(.value) { (snapShot) in
            var listResult = [TardisFriendObject]()
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
                guard let object = TardisFriendObject.init(JSON: value) else {
                    completionBlock(false,[])
                    return
                }
                
                object.friendID = key
                listResult.append(object)
            }
            completionBlock(true,listResult)
        }
    }
    func observeChat(withID chatID: String, completionBlock: @escaping (Bool,[TardisChatObject]) -> Void) {
        chatRef.child(chatID).observe(.value) { (snapShot) in
            var listResult = [TardisChatObject]()
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
                guard let object = TardisChatObject.init(JSON: value) else {
                    completionBlock(false,[])
                    return
                }
                
                object.id = key
                listResult.append(object)
            }
            completionBlock(true,listResult)
        }
    }
    func inviteFriend(user: UserInfoObject, completionBlock: @escaping (Bool) -> Void) {
        let newFriend = TardisFriendObject()
        newFriend.friendID = user.UID
        newFriend.status = FriendStatus.invited.rawValue
        friendListRef.child(UserInfo.getUID()).child(newFriend.friendID).setValue(newFriend.toJSON()) { (err, ref) in
            if err != nil {
                completionBlock(false)
                return
            }
            completionBlock(true)
        }
    }
}
