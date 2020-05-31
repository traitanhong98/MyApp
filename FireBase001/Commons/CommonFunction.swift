//
//  CommonFunction.swift
//  FireBase001
//
//  Created by Hoang on 5/14/20.
//  Copyright © 2020 Hoang. All rights reserved.
//

import Foundation
import UIKit
class CommonFunction {
    static func resizeImage (image: UIImage,targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    func cropToBounds(image: UIImage, width: Double, height: Double) -> UIImage {

        let contextImage: UIImage = UIImage(cgImage: image.cgImage!)

        let contextSize: CGSize = contextImage.size

        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = CGFloat(width)
        var cgheight: CGFloat = CGFloat(height)

        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }

        let rect: CGRect = CGRect(x: posX, y: posY, width: cgwidth, height: cgheight)

        // Create bitmap image from context using the rect
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!

        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)

        return image
    }
    
    static func makeTimeStringFromFloat(time: Float) -> String {
        let hour = Int(time / 100)
        let minute = Int(time - Float(hour * 100))
        if minute == 0 {
            return "\(hour):00"
        }
        return "\(hour):\(minute)"
    }
    //Date-Time
    static func getCurrentDay() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyy"
        let result = formatter.string(from: date)
        return result
    }
    static func getCurrenTime() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let result = formatter.string(from: date)
        return result
    }
    static func getCurrenFloatTime() -> Float {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmm"
        let result = formatter.string(from: date)
        let floatResult = Float(result) ?? 0
        return self.getFloatTime(time: floatResult)
    }
    static func getCurrentDayOfWeek() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        let result = formatter.string(from: date)
        return result
    }
    static func getFloatTime(time: Float) -> Float {
        let timeHour = Float(Int(time / 100))
        let timeMinute = time - timeHour
        return timeHour + timeMinute / 60 * 100
    }
    //GetSize
    static func getSizeWithRatio(width: Float, height: Float, ratio: Float) -> CGSize {
        return CGSize(width: CGFloat(width * ratio), height: CGFloat(height * ratio))
    }
    
}
