//
//  TardisLoginRequestModel.swift
//  FireBase001
//
//  Created by Hoang on 5/11/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit
import Firebase
class TardisLoginRequestModel:NSObject {
    static let shared = TardisLoginRequestModel()
    
    var firRef: DatabaseReference
    override init() {
        self.firRef = TardisModel.shared.firRef
    }
    
    func login(username: String, password: String, completionBlock: ((Bool) -> Void)?) {
        Auth.auth().signIn(withEmail: username, password: password) { [weak self] authResult, error in
            if let completionBlock = completionBlock {
                completionBlock(true)
            } 
        }
    }
}
