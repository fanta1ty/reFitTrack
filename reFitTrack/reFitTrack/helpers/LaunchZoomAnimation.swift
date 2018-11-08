//
//  LaunchZoomAnimation.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

//Image width
fileprivate let startAnimationImageWidth: CGFloat  = 172.0
fileprivate let finishAnimationImageWidth: CGFloat = 2000.0

//Transform
fileprivate let transformAnimationDuration: TimeInterval = 0.3
fileprivate let transformAnimationDelay: TimeInterval    = 1.0

//Mask background image view
fileprivate let maskBackgroundImageViewAnimationDuration: TimeInterval  = 0.1
fileprivate let maskBackgroundImageViewAnimationDelay: TimeInterval     = 1.1

struct LaunchZoomAnimation {
    static func performAnimation(window: UIWindow?,
                                 navigationControllerIdentifier: String,
                                 backgroundImage: UIImage?,
                                 animationImage: UIImage?) {
        
        guard let window = window,
              let backgroundImage = backgroundImage,
              let animationImage  = animationImage else {
            return
        }
        
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = backgroundImage
        window.addSubview(backgroundImageView)
        window.makeKeyAndVisible()
        
        let mainStoryboard = UIStoryboard(name: StoryboardConstants.defaultStoryboard.rawValue,
                                          bundle: nil)
        
        let navigationController = mainStoryboard.instantiateViewController(withIdentifier: navigationControllerIdentifier) as? UINavigationController
        
        guard let navController = navigationController else {
            return
        }
        
        window.rootViewController = navigationController
        
        navController.view.layer.mask               = CALayer()
        navController.view.layer.mask!.contents     = animationImage.cgImage
        navController.view.layer.mask!.bounds       = CGRect(x: 0,
                                                             y: 0,
                                                             width: startAnimationImageWidth,
                                                             height: startAnimationImageWidth)
        navController.view.layer.mask!.anchorPoint  = CGPoint(x: 0.5, y: 0.5)
        navController.view.layer.mask!.position     = CGPoint(x: navController.view.frameWidth() / 2,
                                                              y: navController.view.frameHeight() / 2)
        
        
        let maskBackgroundImageView     = UIImageView(frame: navController.view.layer.mask!.frame)
        maskBackgroundImageView.image   = animationImage
        
        navController.view.addSubview(maskBackgroundImageView)
        navController.view.bringSubviewToFront(maskBackgroundImageView)
        
        performTransformAnimation(navigationController: navController,
                                  maskBackgroundImageView: maskBackgroundImageView)
        
        performBackgroundImageViewAnimation(navigationController: navController,
                                            maskBackgroundImageView: maskBackgroundImageView)
    }
    
    fileprivate static func performTransformAnimation(navigationController: UINavigationController,
                                                      maskBackgroundImageView: UIImageView) {
        let firstBounds = NSValue(cgRect: navigationController.view.layer.mask!.bounds)
        let finalBounds = NSValue(cgRect: CGRect(x: 0,
                                                 y: 0,
                                                 width: finishAnimationImageWidth,
                                                 height: finishAnimationImageWidth))
        
        let transformAnimation                      = CAKeyframeAnimation(keyPath: "bounds")
        transformAnimation.duration                 = transformAnimationDuration
        transformAnimation.beginTime                = CACurrentMediaTime() + transformAnimationDelay
        transformAnimation.values                   = [firstBounds, finalBounds]
        transformAnimation.timingFunctions          = [CAMediaTimingFunction(name: .linear)]
        transformAnimation.isRemovedOnCompletion    = false
        transformAnimation.fillMode                 = .forwards
        
        navigationController.view.layer.mask!.add(transformAnimation, forKey: "maskAnimation")
        maskBackgroundImageView.layer.add(transformAnimation, forKey: "maskAnimation")
    }
    
    fileprivate static func performBackgroundImageViewAnimation(navigationController: UINavigationController,
                                                                maskBackgroundImageView: UIImageView) {
        UIView.animate(withDuration: maskBackgroundImageViewAnimationDuration, delay: maskBackgroundImageViewAnimationDelay, options: .curveEaseIn, animations: {
            maskBackgroundImageView.alpha = 0.0
        }) { _ in
            maskBackgroundImageView.removeFromSuperview()
            navigationController.view.layer.mask = nil
        }
    }
}
