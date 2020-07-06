//
//  TardisChatObjectModel.swift
//  FireBase001
//
//  Created by Hoang on 7/6/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import MessageKit
import ObjectMapper

class TardisChatObjectModel: NSObject {

}
enum FriendStatus: String {
    case invited = "invited"
    case waiting = "waiting"
    case connected = "connected"
}
class TardisFriendObject: NSObject, Mappable {
    required init?(map: Map) {
    }
    override init() {
    }
    func mapping(map: Map) {
        status <- map["accepted"]
        messageID <- map["message_ID"]
        lastMessage <- map["last_message"]
    }
    var friendID = ""
    var status = ""
    var messageID = ""
    var lastMessage = TardisChatObject()
    
}
class TardisChatObject: NSObject, Mappable {
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

extension TardisChatObject: MessageType {
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
