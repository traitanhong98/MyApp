//
//  TardisChannelObject.swift
//  FireBase001
//
//  Created by Hoang on 7/4/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import Foundation
import ObjectMapper
import MessageKit

class TardisChannelObject: NSObject, Mappable {
    var id = ""
    var createdTime = CommonFunction.getCurrentDateString(withFormat: "HH:mm dd/MM/yy")
    var channelName = ""
    var usersID = [String]()
    var chatID = ""
    var checkListID = ""
    var ownerID = ""
    var messageID = ""
    var activityID = ""
    required init?(map: Map) {
    }
    override init() {}
    func mapping(map: Map) {
        channelName <- map["channel_name"]
        usersID <- map["users_ID"]
        chatID <- map["chat_ID"]
        checkListID <- map["check_list_ID"]
        ownerID <- map["owner_ID"]
        messageID <- map["message_ID"]
        activityID <- map["activity_ID"]
        createdTime <- map["created_time"]
    }
}

class TardisMessageObject: NSObject, Mappable {
    required init?(map: Map) {}
    override init() {}
    func mapping(map: Map) {
        content <- map["content"]
        senderID <- map["sender_id"]
        sendTime <- map["send_time"]
        senderName <- map["sender_name"]
    }
    var id = ""
    var content = ""
    var senderID = ""
    var sendTime = Date().timeIntervalSince1970
    var senderName = ""
}

extension TardisMessageObject: MessageType {
    var sender: SenderType {
        return Sender(senderId: senderID, displayName: senderName)
    }
    
    var messageId: String {
        return id
    }
    
    var sentDate: Date {
        let myTimeInterval = TimeInterval(sendTime)
        return Date(timeIntervalSince1970: TimeInterval(myTimeInterval))
    }
    
    var kind: MessageKind {
        return .text(content)
    }
    
    
}
class TardisChannelChecklistObject: Mappable {
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        status <- map["status"]
        note <- map["note"]
        assignee <- map["assignee"]
        tag <- map["Tag"]
    }
    
    var status = false
    var note = ""
    var assignee = ""
    var tag = ""
}
