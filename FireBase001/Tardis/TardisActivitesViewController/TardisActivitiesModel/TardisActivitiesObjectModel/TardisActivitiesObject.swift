//
//  TardisActivitiesObject.swift
//  FireBase001
//
//  Created by Hoang on 5/21/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import ObjectMapper


class TardisActivity: Mappable {
    var activityName: String    = ""
    var startTime:Float         = 0
    var endTime:Float           = 0
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
}

