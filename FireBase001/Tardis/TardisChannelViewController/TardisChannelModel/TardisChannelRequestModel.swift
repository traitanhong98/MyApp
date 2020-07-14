//
//  TardisChannelRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 7/4/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase

class TardisChannelRequestModel: NSObject {
    static let shared = TardisChannelRequestModel()
    var channelRef = TardisBaseRequestModel.shared.firRef.child("Channels")
    var messageRef = TardisBaseRequestModel.shared.firRef.child("Channels_Message")
    var checkListRef = TardisBaseRequestModel.shared.firRef.child("Channel_CheckList")
    var activityRef = TardisBaseRequestModel.shared.firRef.child("Channel_Activity")
    
    // MARK: - SingleEvent
    func loadChannels(completionBlock: @escaping (Bool,[TardisChannelObject])->Void) {
        var listChannels = [TardisChannelObject]()
        CommonFunction.showLoadingView()
        let dispatchGroup = DispatchGroup()
        for channel in UserInfo.currentUser.channels {
            dispatchGroup.enter()
            self.channelRef.child(channel).observeSingleEvent(of: .value) { (snapShot) in
                guard let value = snapShot.value as? [String:Any] else {
                    dispatchGroup.leave()
                    return
                }
                let key = snapShot.key
                guard let channel = TardisChannelObject.init(JSON: value) else {
                    dispatchGroup.leave()
                    return
                }
                channel.id = key
                listChannels.append(channel)
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            CommonFunction.hideLoadingView()
            completionBlock(true,listChannels)
        }
    }
    // MARK: - Observe
    func observeChannel(_ channel: TardisChannelObject, completionBlock: @escaping (Bool) -> Void) {
        let currentChannel = channelRef.child(channel.id)
        currentChannel.observe(.childChanged) { (snapShot) in
            
        }
    }
    func observeActivity(onChannel channel: TardisChannelObject, completionBlock: @escaping (Bool, TardisChannelActivityObject) -> Void) {
        let currentActivity = activityRef.child(channel.activityID)
        currentActivity.observe(.value) { (snapShot) in
            guard let value = snapShot.value as? [String:Any] else {
                completionBlock(false,TardisChannelActivityObject())
                return
            }
            guard let activity = TardisChannelActivityObject.init(JSON: value) else {
                completionBlock(false,TardisChannelActivityObject())
                return
            }
            completionBlock(true,activity)
        }
    }
    func observeChat(onChannel channel: TardisChannelObject, completionBlock: @escaping (Bool, [TardisMessageObject]) -> Void) {
        let currentChat = messageRef.child(channel.chatID)
        currentChat.observe(.value) { (snapShot) in
            var chatList = [TardisMessageObject]()
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
                guard let message = TardisMessageObject.init(JSON: value) else {
                    completionBlock(false,[])
                    return
                }
                message.id = key
                chatList.append(message)
            }
            completionBlock(true,chatList)
        }
    }
    func observeCheckList(onChannel channel: TardisChannelObject, completionBlock: @escaping (Bool, [TardisChannelChecklistObject]) -> Void) {
        let currentChecklistRef = checkListRef.child(channel.checkListID)
        currentChecklistRef.observe(.value) { (snapShot) in
            var checklist = [TardisChannelChecklistObject]()
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
                guard let object = TardisChannelChecklistObject.init(JSON: value) else {
                    completionBlock(false,[])
                    return
                }
                object.id = key
                checklist.append(object)
            }
            completionBlock(true,checklist)
        }
    }
    func removeChatObserver(onChannel channel: TardisChannelObject) {
        messageRef.child(channel.chatID).removeAllObservers()
    }
    // MARK: - ADD
    func addNewChannel(name: String,completionBlock: @escaping (Bool,TardisChannelObject)->Void) {
        CommonFunction.showLoadingView()
        let newChannel = channelRef.childByAutoId()
        let newChannelObject = TardisChannelObject()
        let key = newChannel.key ?? ""
        newChannelObject.id = key
        newChannelObject.channelName = name
        
        let newCheckList = checkListRef.childByAutoId()
        newChannelObject.checkListID = newCheckList.key ?? ""
        
        let newActivity = activityRef.childByAutoId()
        newChannelObject.activityID = newActivity.key ?? ""
        
        let newChat = messageRef.childByAutoId()
        newChannelObject.chatID = newChat.key ?? ""
        
        newChannelObject.ownerID = UserInfo.getUID()
        newChannelObject.usersID = [UserInfo.getUID()]
        UserInfo.currentUser.channels.append(newChannelObject.id)
        channelRef.child(newChannelObject.id).setValue(newChannelObject.toJSON()) { (err, ref) in
            if err != nil {
                completionBlock(false,TardisChannelObject())
                return
            }
            TardisBaseRequestModel.shared.firRef.child("Users").child(UserInfo.getUID()).child("channels").setValue(UserInfo.currentUser.channels)
            CommonFunction.hideLoadingView()
            completionBlock(true,newChannelObject)
        }
    }
    func addNewMessage(_ message: TardisMessageObject,
                       toChannel channel: TardisChannelObject,
                       completionBlock: @escaping (Bool) -> Void ) {
        let currentMessageRef = messageRef.child(channel.chatID)
        let newMessage = currentMessageRef.childByAutoId()
        newMessage.setValue(message.toJSON()) { (err, ref) in
            if err != nil {
                completionBlock(false)
                return
            }
            completionBlock(true)
        }
    }
    func addNewCheckList(_ checkList: TardisChannelChecklistObject,
                         toChannel channel: TardisChannelObject,
                         completionBlock: @escaping (Bool) -> Void) {
        let currentCheckListRef = checkListRef.child(channel.checkListID)
        let newChecklist = currentCheckListRef.childByAutoId()
        newChecklist.setValue(checkList.toJSON()) { (err, ref) in
            if err != nil {
                completionBlock(false)
                return
            }
            completionBlock(true)
        }
    }
    func addNewActivity(_ activity: TardisChannelActivityObject,
                        toChannel channel: TardisChannelObject,
                        completionBlock: @escaping (Bool) -> Void) {
        let currentActivityRef = activityRef.child(channel.activityID)
        currentActivityRef.setValue(activity.toJSON()) { (err, ref) in
            if err != nil {
                completionBlock(false)
                return
            }
            completionBlock(true)
        }
    }
    
    func addNewMember(_ memberID: String,
                      toChannel channel: TardisChannelObject,
                      completionBlock: @escaping (Bool) -> Void){
        let currentChannelRef = channelRef.child(channel.id)
        currentChannelRef.child("users_ID").setValue(memberID) { (err, ref) in
            if err != nil {
                completionBlock(false)
                return
            }
            completionBlock(true)
        }
    }
    func observeForMessage(onChannel channel: TardisChannelObject,
                           completionBlock: @escaping (Bool,TardisMessageObject) -> Void) {
        let currentMessageRef = messageRef.child(channel.messageID)
        currentMessageRef.observe(.childAdded) { (snapShot) in
            
        }
    }
    func removeAllObserver() {
        channelRef.removeAllObservers()
        messageRef.removeAllObservers()
        checkListRef.removeAllObservers()
        activityRef.removeAllObservers()
    }
}
