//
//  TardisScheduleObjectModel.swift
//  FireBase001
//
//  Created by Hoang on 6/25/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import ObjectMapper
class TardisScheduleObject: Mappable {
   
    
    var id = ""
    var name = ""
    var date = ""
    var des = ""
    var startDay = ""
    var endDay = ""
    var startTime = ""
    var endTime = ""
    var tag = ""
    var checkList = [TardisCheckListObject]()
    
    required init?(map: Map) {}
       
    init() {
    }
    func mapping(map: Map) {
        name         <- map["name"]
        startTime    <- map["start_time"]
        endTime      <- map["end_time"]
        des          <- map["des"]
        checkList    <- map["check_list"]
        date         <- map["date"]
        startDay     <- map["start_day"]
        endDay       <- map["end_Day"]
       }
    convenience init(name: String, date: String,startDay: String, endDay: String, startTime: String, endTime: String, checkList: [TardisCheckListObject]) {
        self.init()
        self.name = name
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.checkList = checkList
        self.startDay = startDay
        self.endDay = endDay
    }
}

class TardisCheckListObject: Mappable {
    var id = ""
    var des = ""
    var status = false
    required init?(map: Map) {}
    init() {}
    func mapping(map: Map) {
        des     <- map["des"]
        status  <- map["status"]
    }
    
    convenience init(withDescription des: String) {
        self.init()
        self.des = des
    }
}
