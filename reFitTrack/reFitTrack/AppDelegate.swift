//
//  AppDelegate.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configuration()
        return true
    }
}

extension AppDelegate {
    fileprivate func configuration() {
        let backgroundImage = UIImage(named: LaunchScreenConstants.backgroundImage.rawValue)
        let animationImage  = UIImage(named: LaunchScreenConstants.logoImage.rawValue)
        
        LaunchZoomAnimation.performAnimation(window: window,
                                             navigationControllerIdentifier: NavigationConstants.defaultNavigation.rawValue,
                                             backgroundImage: backgroundImage,
                                             animationImage: animationImage)
    }
}

