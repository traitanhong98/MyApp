//
//  TardisSignupRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 6/3/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase

class TardisSignupRequestModel: NSObject {
    static let shared = TardisSignupRequestModel()
    
    var firRef: DatabaseReference
    override init() {
        self.firRef = TardisModel.shared.firRef
    }
}
