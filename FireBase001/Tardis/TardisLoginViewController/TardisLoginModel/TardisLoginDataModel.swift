//
//  TardisLoginDataModel.swift
//  FireBase001
//
//  Created by Hoang on 6/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisLoginDataModel: NSObject {
    var selfView: TardisLoginViewController?
    var requestModel: TardisLoginRequestModel?
    override init() {
        requestModel = TardisLoginRequestModel.shared
    }
    func doLogin(username: String, password: String, completionBlock: @escaping (Bool)-> Void) {
        if requestModel == nil {
            requestModel = TardisLoginRequestModel.shared
        }
        requestModel?.login(username: username, password: password) { (status) in
            completionBlock(status)
        }
    }
}
