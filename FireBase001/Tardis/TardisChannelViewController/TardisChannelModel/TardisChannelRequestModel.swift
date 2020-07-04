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
    var channelRef = TardisBaseRequestModel.shared.firRef.child("Channels")
    var messageRef = TardisBaseRequestModel.shared.firRef.child("Channels_Message")
    var checkListRef = TardisBaseRequestModel.shared.firRef.child("Channel_CheckList")
    var activityRef = TardisBaseRequestModel.shared.firRef.child("Channel_Activity")
    func addNewChannel(completionBlock: @escaping (Bool,TardisChannelObject)->Void) {
        CommonFunction.showLoadingView()
        let newChannel = channelRef.childByAutoId()
        let newChannelObject = TardisChannelObject()
        let key = newChannel.key ?? ""
        newChannelObject.id = key
        
        let newMessage = messageRef.childByAutoId()
        newChannelObject.messageID = newMessage.key ?? ""
        
        let newCheckList = checkListRef.childByAutoId()
        newChannelObject.checkListID = newCheckList.key ?? ""
        
        let newActivity = activityRef.childByAutoId()
        newChannelObject.activityID = newActivity.key ?? ""
        
        newChannelObject.ownerID = UserInfo.getUID()
        newChannelObject.usersID = [UserInfo.getUID()]
        channelRef.child(newChannelObject.id).setValue(newChannelObject.toJSON()) { (err, ref) in
            if err != nil {
                completionBlock(false,TardisChannelObject())
                return
            }
            completionBlock(true,newChannelObject)
        }
    }
    func addNewMessage(_ message: TardisMessageObject,
                       toChannel channel: TardisChannelObject,
                       completionBlock: @escaping (Bool) -> Void ) {
        let currentMessageRef = messageRef.child(channel.messageID)
        let newMessage = currentMessageRef.childByAutoId()
        newMessage.setValue(message.toJSON()) { (err, ref) in
            if err != nil {
                completionBlock(false)
                return
            }
            completionBlock(true)
        }
    }
    func addNewCheckList(_ checkList: TardisCheckListObject,
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
    func addNewActivity(_ activity: TardisActivityObject,
                        toChannel channel: TardisChannelObject,
                        completionBlock: @escaping (Bool) -> Void) {
        let currentActivityRef = checkListRef.child(channel.activityID)
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
}
