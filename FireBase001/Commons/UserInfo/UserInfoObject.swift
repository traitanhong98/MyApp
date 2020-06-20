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
    
    var username = ""
    var displayName = ""
    var email = ""
    var imageUrl = ""
    var birthDay = ""
    var phoneNumber = ""
    
    init() {}
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        username    <- map["username"]
        displayName <- map["display_name"]
        email       <- map["password"]
        imageUrl    <- map["image_url"]
        birthDay    <- map["birthday"]
        phoneNumber <- map["phonenumber"]
    }
    
    init(username: String,displayName: String,email: String, imageUrl: String, birthday: String, phonenumber:String) {
        self.username = username
        self.displayName = displayName
        self.email = email
        self.imageUrl = imageUrl
        self.birthDay = birthday
        self.phoneNumber = phonenumber
    }
    
}
