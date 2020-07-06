//
//  UserInfoObject.swift
//  FireBase001
//
//  Created by Hoang on 6/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import ObjectMapper

class UserInfoObject: Mappable {
    var UID = ""
    var displayName = ""
    var email = ""
    var imageUrl = ""
    var birthDay = ""
    var phoneNumber = ""
    var isLogin = true
    var lastOnline = Date().timeIntervalSince1970
    var location = Location()
    var gender = "Male"
    var channels = [String]()
    var chats = [String]()
    var hobbies = [String]()
    
    init() {}
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        displayName <- map["display_name"]
        email       <- map["email"]
        imageUrl    <- map["image_url"]
        birthDay    <- map["birthday"]
        phoneNumber <- map["phonenumber"]
        channels    <- map["channels"]
        chats       <- map["chats"]
        hobbies     <- map["hobbies"]
        location    <- map["location"]
        isLogin     <- map["is_login"]
        lastOnline   <- map["last_online"]
        hobbies     <- map["hobbies"]
    }
}
class Location: Mappable {
    required init?(map: Map) {
    }
    init() {}
    func mapping(map: Map) {
        latitude <- map["latitude"]
        longtitude <- map["longtitude"]
    }
    var latitude: Double = 0
    var longtitude: Double = 0
    
}
