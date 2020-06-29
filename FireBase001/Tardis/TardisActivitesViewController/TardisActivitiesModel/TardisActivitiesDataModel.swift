//
//  TardisActivitiesDataModel.swift
//  FireBase001
//
//  Created by Hoang on 6/12/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import UIKit

class TardisActivitiesDataModel: NSObject {
    static let shared = TardisActivitiesDataModel()
    
    var selfView: TardisActivitiesViewController?
    var requestModel = TardisActivitiesRequestModel()
    var activitiesArray = [TardisActivityObject]()
    var dailyActivityArray = [[TardisActivityObject]] ()
    override init() {
        super.init()
        setupData()
    }
    func setupData() {
        dailyActivityArray.removeAll()
        for _ in 1...7 {
            dailyActivityArray.append([TardisActivityObject]())
        }
    }
    func separateActivity () {
        for activity in activitiesArray {
            if activity.loopDay.count > 0 {
                let days = activity.loopDay.split(" ")
                for day in days {
                    guard let index = Int(day) else {break}
                    dailyActivityArray[index].append(activity)
                }
            }
        }
        for index in 0..<dailyActivityArray.count {
            dailyActivityArray[index].sort(by: {$0.startTime < $1.startTime})
        }
    }
    func addActivity(activity: TardisActivityObject, completionBlock: @escaping (Bool)->Void) {
        requestModel.addActivity(activity: activity) { (status, activity) in
            if status {
                self.activitiesArray.append(activity)
                self.setupData()
                self.separateActivity()
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
    func loadActivities( completionBlock: @escaping (Bool)-> Void ) {
        requestModel.loadActivities { (status, activitiesArray) in
            if status {
                self.activitiesArray.removeAll()
                self.activitiesArray = activitiesArray
                self.setupData()
                self.separateActivity()
                completionBlock(true)
            } else {
                completionBlock(false)
            }
        }
    }
}
