//
//  TardisBaseMapObject.swift
//  FireBase001
//
//  Created by Hoang on 7/6/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import ObjectMapper

class TardisBaseMapObject: NSObject, Mappable {
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
    }
    var id = ""
}
