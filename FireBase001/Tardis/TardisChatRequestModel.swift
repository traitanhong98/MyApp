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
    static let shared = TardisChatRequestModel()
    var friendListRef = TardisBaseRequestModel.shared.firRef.child("Friends")
    var chatRef = TardisBaseRequestModel.shared.firRef.child("Friends_Chats")
    
    
    func observeFriend(status: FriendStatus, completionBlock: @escaping (Bool,[TardisFriendObject]) -> Void) {
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
                if object.status == status.rawValue {
                    object.friendID = key
                    listResult.append(object)
                }
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
    func inviteFriend(otherUser: UserInfoObject, completionBlock: @escaping (Bool) -> Void) {
        let ownerNewFriend = TardisFriendObject()
        ownerNewFriend.friendID = otherUser.UID
        ownerNewFriend.status = FriendStatus.invited.rawValue
        friendListRef.child(UserInfo.getUID()).child(ownerNewFriend.friendID).setValue(ownerNewFriend.toJSON()) { (err, ref) in
            if err != nil {
                completionBlock(false)
                return
            }
            let newFriend = TardisFriendObject()
            newFriend.friendID = UserInfo.getUID()
            newFriend.status = FriendStatus.waiting.rawValue
            self.friendListRef.child(otherUser.UID).child(UserInfo.getUID()).setValue(newFriend.toJSON())
            { (err, ref) in
                if err != nil {
                    completionBlock(false)
                    return
                }
                completionBlock(true)
            }
        }
    }
    func rejectInvitation(ofUser user: UserInfoObject, completionBlock: @escaping (Bool) -> Void) {
        friendListRef.child(UserInfo.getUID()).child(user.UID).removeValue { (err, ref) in
            if err != nil {
                completionBlock(false)
                return
            }
            self.friendListRef.child(user.UID).child(UserInfo.getUID()).removeValue { (err, ref) in
                if err != nil {
                    completionBlock(false)
                    return
                }
                completionBlock(true)
            }
        }
    }
    func acceptInvitation(ofUser user: UserInfoObject, completionBlock: @escaping (Bool) -> Void) {
        let newChat = chatRef.childByAutoId()
        friendListRef.child(UserInfo.getUID()).child(user.UID).child("accepted").setValue(FriendStatus.connected.rawValue) { (err, ref) in
            if err != nil {
                completionBlock(false)
                return
            }
            self.friendListRef.child(UserInfo.getUID()).child(user.UID).child("message_ID").setValue(newChat.key);
            self.friendListRef.child(user.UID).child(UserInfo.getUID()).child("accepted").setValue(FriendStatus.connected.rawValue)
            { (err, ref) in
                if err != nil {
                    completionBlock(false)
                    return
                }
                self.friendListRef.child(user.UID).child(UserInfo.getUID()).child("message_ID").setValue(newChat.key)
                completionBlock(true)
            }
        }
    }
    func observeChat(withPath path: String, completionBlock: @escaping (Bool, [TardisChatObject]) -> Void) {
        let currentChat = chatRef.child(path)
        currentChat.observe(.value) { (snapShot) in
            var chatList = [TardisChatObject]()
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
                guard let message = TardisChatObject.init(JSON: value) else {
                    completionBlock(false,[])
                    return
                }
                message.id = key
                chatList.append(message)
            }
            completionBlock(true,chatList)
        }
    }
    func addNewMessage(_ message: TardisChatObject,
                       toPath path: String,
                       completionBlock: @escaping (Bool) -> Void ) {
        let currentMessageRef = chatRef.child(path)
        let newMessage = currentMessageRef.childByAutoId()
        newMessage.setValue(message.toJSON()) { (err, ref) in
            if err != nil {
                completionBlock(false)
                return
            }
            completionBlock(true)
        }
    }
}
