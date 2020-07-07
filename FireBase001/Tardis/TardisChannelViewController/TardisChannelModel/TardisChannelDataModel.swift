//
//  TardisChannelDataModel.swift
//  FireBase001
//
//  Created by Hoang on 7/4/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisChannelDataModel: NSObject {
    static let shared = TardisChannelDataModel()
    let requestModel = TardisChannelRequestModel.shared
    var listChannel = [TardisChannelObject]()
    var selfView: TardisChannelViewController?
    
    func loadChannels( completionBlock: @escaping (Bool) -> Void) {
        requestModel.loadChannels { (status, listChannel) in
            if status {
                self.listChannel = listChannel
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    func createChannel(_ name: String, completionBlock: @escaping (Bool) -> Void) {
        requestModel.addNewChannel(name: name) { (status, channel) in
            if status {
                self.listChannel.append(channel)
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    func observeChat(onChannel channel: TardisChannelObject,
                     completionBlock: @escaping (Bool, [TardisMessageObject]) -> Void) {
        requestModel.observeChat(onChannel: channel) { (status, listMessage) in
            if status {
                completionBlock(true, listMessage)
            } else {
                completionBlock(false,[])
            }
        }
    }
    func addNewMessage(_ message: TardisMessageObject,
                       toChannel channel: TardisChannelObject,
                       completionBlock: @escaping (Bool) -> Void ) {
        requestModel.addNewMessage(message,
                                   toChannel: channel) { (status) in
                                    if status {
                                        completionBlock(true)
                                    } else {
                                        completionBlock(false)
                                    }
        }
    }
    
    func observeActivity(onChannel channel: TardisChannelObject, completionBlock: @escaping (Bool, TardisChannelActivityObject) -> Void) {
        requestModel.observeActivity(onChannel: channel) { (status, object) in
            completionBlock(status, object)
        }
    }
    func reset() {
        listChannel.removeAll()
        requestModel.removeAllObserver()
    }
    deinit {
        requestModel.removeAllObserver()
    }
}
