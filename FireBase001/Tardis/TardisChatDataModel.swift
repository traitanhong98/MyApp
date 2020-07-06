//
//  TardisChatDataModel.swift
//  FireBase001
//
//  Created by Hoang on 7/6/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisChatDataModel: NSObject {
    static let shared = TardisChatDataModel()
    let requestModel = TardisChatRequestModel.shared
    func observeFriend(status: FriendStatus, completionBlock: @escaping (Bool,[TardisFriendObject]) -> Void) {
        requestModel.observeFriend(status: status) { (status, listFriend) in
            if status {
                completionBlock(true, listFriend)
            } else {
                completionBlock(false, listFriend)
            }
        }
    }
    func inviteFriend(otherUser: UserInfoObject, completionBlock: @escaping (Bool) -> Void) {
        requestModel.inviteFriend(otherUser: otherUser) { (status) in
            completionBlock(status)
        }
    }
    func rejectInvitation(ofUser user: UserInfoObject, completionBlock: @escaping (Bool) -> Void) {
        requestModel.rejectInvitation(ofUser: user) { (status) in
            completionBlock(status)
        }
    }
    func acceptInvitation(ofUser user: UserInfoObject, completionBlock: @escaping (Bool) -> Void) {
        requestModel.acceptInvitation(ofUser: user) { (status) in
            completionBlock(status)
        }
    }
    func observeChat(withPath path: String, completionBlock: @escaping (Bool, [TardisChatObject]) -> Void) {
        requestModel.observeChat(withID: path) { (status, listChat) in
            completionBlock(status,listChat)
        }
    }
    func addNewMessage(_ message: TardisChatObject,
                       toPath path: String,
                       completionBlock: @escaping (Bool) -> Void ) {
        requestModel.addNewMessage(message, toPath: path) { (status) in
            completionBlock(status)
        }
    }
}
