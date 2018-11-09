//
//  Constants.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import Foundation

enum LaunchScreenImageConstants: String {
    case background  = "01_01_Background"
    case logo        = "01_02_Logo"
}

enum MainScreenImageConstants: String {
    case runNormal      = "02_01_Logo"
    case runActive      = "02_02_Logo"
    
    case bikeNormal     = "02_03_Logo"
    case bikeActive     = "02_04_Logo"
    
    case calNormal      = "02_05_Logo"
    case calActive      = "02_06_Logo"
    
    case disNormal      = "02_07_Logo"
    case disActive      = "02_08_Logo"
    
    case sleepNormal    = "02_09_Logo"
    case sleepActive    = "02_10_Logo"
    
    case title          = "02_11_Logo"
    case line           = "02_12_Line"
    
    case whiteBackgroundBottom  = "02_13_Background"
    case whiteBackgroundMiddle  = "02_14_Background"
    case whiteBackgroundTop     = "02_15_Background"
    
    case blueGradient       = "02_16_Gradient"
    case greenGradient      = "02_17_Gradient"
    case orangeGradient     = "02_18_Gradient"
    case pinkGradient       = "02_19_Gradient"
    case purpleGradient     = "02_20_Gradient"
    
    case calendar           = "02_21_Icon"
    case settings           = "02_22_Icon"
}

enum NavigationConstants: String {
    case defaultNavigation = "navigationController"
}

enum StoryboardConstants: String {
    case defaultStoryboard = "Main"
}

enum FontNameConstants: String {
    case normal = "HelveticaNeue"
    case light  = "HelveticaNeue-Light"
    case bold   = "HelveticaNeue-Bold"
}
