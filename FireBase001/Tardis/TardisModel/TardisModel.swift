//
//  TardisModel.swift
//  FireBase001
//
//  Created by Hoang on 6/3/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
class TardisModel: NSObject {
    static let shared = TardisModel()
    var firRef: DatabaseReference
    override init() {
        firRef = Database.database().reference(fromURL: "https://fir-001app.firebaseio.com/")
    }
    
    func createChild(childName: String,completionBlock: ()->Void) {
        
    }
    
}
