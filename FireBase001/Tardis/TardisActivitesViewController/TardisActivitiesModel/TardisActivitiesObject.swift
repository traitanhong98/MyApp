//
//  TardisActivitiesObject.swift
//  FireBase001
//
//  Created by Hoang on 5/21/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import ObjectMapper


class TardisActivityObject: Mappable {
    var activityName: String    = ""
    var startTime:String        = ""
    var endTime:String          = ""
    var note:String             = ""
    var location:String         = ""
    var loopDay:[String]        = []
    init() {}

    required init?(map: Map) {}

    func mapping(map: Map) {
        activityName    <- map["activitiy_name"]
        startTime       <- map["start_time"]
        endTime         <- map["end_time"]
        note            <- map["note"]
        location        <- map["location"]
        loopDay         <- map["loop_day"]
    }
    
    convenience init(activityName: String,startTime:String,endTime:String,note:String,location:String) {
        self.init()
        self.activityName = activityName
        self.startTime = startTime
        self.endTime = endTime
        self.note = note
        self.location = location
    }
}

//class TardisJsonActivityObject: Mappable {
//    
//    required init?(map: Map) {}
//    
//    mutating func mapping(map: Map) {
//        <#code#>
//    }
//    
//}
