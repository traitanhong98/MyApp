//
//  TardisSignUpDataModel.swift
//  FireBase001
//
//  Created by Hoang on 6/11/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisSignUpDataModel: NSObject {
    var requestModel: TardisSignupRequestModel?
    var selfView: TardisSignupViewController?
    
    override init() {
        requestModel = TardisSignupRequestModel.shared
    }
    
    init(selfView: TardisSignupViewController) {
        self.selfView = selfView
        self.requestModel = TardisSignupRequestModel.shared
    }
    
    func registerNewUser(username: String,
                         password: String,
                         completionBlock: @escaping (Bool)->Void) {
        if requestModel == nil {
            requestModel = TardisSignupRequestModel.shared
        }
        requestModel?.registerNewUserWithMail(userName: username,
                                              password: password,
                                              completionBlock: completionBlock)
    }
}
