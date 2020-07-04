//
//  TardisChannelObject.swift
//  FireBase001
//
//  Created by Hoang on 7/4/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import Foundation
import ObjectMapper

class TardisChannelObject: NSObject, Mappable {
    var id = ""
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
        chatID <- map["chatID"]
        checkListID <- map["check_list_ID"]
        ownerID <- map["owner_ID"]
        messageID <- map["message_ID"]
        activityID <- map["activity_ID"]
    }
}

class TardisMessageObject: Mappable {
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
    }
    
    var id = ""
    var text = ""
    var senderID = ""
    var sendTime = ""
}

class TardisChannelChecklistObject: Mappable {
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
    }
    
    var checked = false
    var note = ""
    var assignee = ""
}
