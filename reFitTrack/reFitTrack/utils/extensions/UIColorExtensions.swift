//
//  UIColorExtensions.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func runActivityColor() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 88.0/255.0, blue: 163.0/255.0, alpha: 1.0)
    }
    
    static func caloriesActivityColor() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 117.0/255.0, blue: 31.0/255.0, alpha: 1.0)
    }
    
    static func distanceActivityColor() -> UIColor {
        return UIColor(red: 80.0/255.0, green: 185.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    static func bikeActivityColor() -> UIColor {
        return UIColor(red: 13.0/255.0, green: 202.0/255.0, blue: 172.0/255.0, alpha: 1.0)
    }
    
    static func sleepActivityColor() -> UIColor {
        return UIColor(red: 111.0/255.0, green: 58.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    static func activeSegmentButtonFontBackgroundColor() -> UIColor {
        return UIColor(red: 149.0/255.0, green: 121.0/255.0, blue: 229.0/255.0, alpha: 1.0)
    }
    
    static func headerSectionBackgroundColor() -> UIColor {
        return UIColor(red: 117.0/255.0, green: 90.0/255.0, blue: 204.0/255.0, alpha: 1.0)
    }
    
    static func navigationBarBackgroundColor() -> UIColor {
        return UIColor(red: 104.0/255.0, green: 75.0/255.0, blue: 195.0/255.0, alpha: 1.0)
    }
}
