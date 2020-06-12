//
//  TardisSignUpDataModel.swift
//  FireBase001
//
//  Created by Hoang on 6/11/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisSignUpDataModel: NSObject {
    static let shared = TardisSignUpDataModel()
    
    var requestModel: TardisSignupRequestModel?
    override init() {
        requestModel = TardisSignupRequestModel.shared
    }
    
    func registerNewUser(username: String,
                         password: String,
                         completionBlock: @escaping (Bool)->Void) {
        if requestModel == nil {
            requestModel = TardisSignupRequestModel.shared
        }
        requestModel?.registerNewUserWithMail(username: username,
                                              password: password,
                                              completionBlock: completionBlock)
    }
}
