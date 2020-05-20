//
//  Strings.swift
//  Heya
//
//  Created by TrungNV on 10/8/19.
//  Copyright © 2019 TrungNV. All rights reserved.
//

import Foundation
import UIKit

enum Weekday:String {
    case Sun = "Sun"
    case Mon = "Mon"
    case Tue = "Tue"
    case Web = "Web"
    case Thu = "Thu"
    case Fri = "Fri"
    case Sat = "Sat"
    case Err = "Err"
    static let allWeekdays = [Sun,Mon,Tue,Web,Thu,Fri,Sat]
    
    static func getWeekday(index: Int)-> Weekday {
        switch index {
        case 0:
            return Sun
        case 1:
            return Mon
        case 2:
            return Tue
        case 3:
            return Web
        case 4:
            return Thu
        case 5:
            return Fri
        case 6:
            return Sat
        default:
            return Err
        }
    }
    
    static func getWeekColor(weekday: Weekday)-> UIColor{
        switch weekday {
        case .Sun:
            return UIColor.yellow
        case .Mon:
            return UIColor.red
        case .Tue:
            return UIColor.green
        case .Web:
            return UIColor.blue
        case .Thu:
            return UIColor.orange
        case .Fri:
            return UIColor.purple
        case .Sat:
            return UIColor.cyan
        default:
            return UIColor.black
        }
    }
}

enum Month:Int {
    case Jan = 0 ,Feb, Mar, Apr, May, Jun,
    Jul, Aug, Sep, Oct, Nov, Dec
}
