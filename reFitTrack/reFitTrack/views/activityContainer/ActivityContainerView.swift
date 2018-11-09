//
//  ActivityContainerView.swift
//  reFitTrack
//
//  Created by trekvn on 11/9/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit
import CoreGraphics

fileprivate let flipAnimationDuration: TimeInterval = 0.2
fileprivate let animateTransformScaleX: CGFloat     = 0.98
fileprivate let animateStateDuration: TimeInterval  = 1
fileprivate let animateSpringDamping: CGFloat       = 0.3
fileprivate let animateSpringVelocity: CGFloat      = 0.7

class ActivityContainerView: UIView {
    static let identifier = "ActivityContainerView"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerGradientView: UIView!
    @IBOutlet weak var progressGradientImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currentProgressLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var helperViewBottomConstraint: NSLayoutConstraint!
    
    fileprivate var subView: UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup(subview: &subView, nibName: ActivityContainerView.identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(subview: &subView, nibName: ActivityContainerView.identifier)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutIfNeeded()
        
        setCornerRadiuses()
    }
}

//MARK: CAAnimationDelegate
extension ActivityContainerView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            configureViewsAfterFlip()
            
            UIView.animate(withDuration: animateStateDuration, delay: 1.0, usingSpringWithDamping: animateSpringDamping, initialSpringVelocity: animateSpringVelocity, options: .curveLinear, animations: {
                self.containerView.transform = CGAffineTransform(scaleX: animateTransformScaleX,
                                                                 y: 1)
            }, completion: nil)
        }
    }
}

//MARK: Public Functions
extension ActivityContainerView {
    func flipView(activity: ActivityModel) {
        configureViewsBeforeFlip(activity: activity)
        
        self.containerView.transform = CGAffineTransform.identity
        
        let transform   = CATransform3DMakeRotation(CGFloat(Double.pi), 0, 1, 0)
        
        let flipAnimation   = CABasicAnimation(keyPath: "transform")
        flipAnimation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        flipAnimation.toValue   = NSValue(caTransform3D: transform)
        flipAnimation.duration  = flipAnimationDuration
        flipAnimation.fillMode  = .both
        flipAnimation.isRemovedOnCompletion = true
        flipAnimation.delegate  = self as CAAnimationDelegate
        
        subView?.layer.add(flipAnimation, forKey: "transform")
    }
}

//MARK: Private Functions
extension ActivityContainerView {
    fileprivate func setCornerRadiuses() {
        layer.cornerRadius              = frameHeight() / 2
        subView!.layer.cornerRadius     = subView!.frameHeight() / 2
        progressGradientImageView.layer.cornerRadius    = progressGradientImageView.frameHeight() / 2
        containerView.layer.cornerRadius                = containerView.frameHeight() / 2
        containerGradientView.layer.cornerRadius        = containerGradientView.frameHeight() / 2
    }
    
    fileprivate func configureViewsBeforeFlip(activity: ActivityModel) {
        titleLabel.isHidden             = true
        titleLabel.text                 = activity.title
        titleLabel.textColor            = activity.activityResource.labelConfigurator?.textColor
        
        if let fontName = activity.activityResource.labelConfigurator?.titleFontName,
            let fontSize = activity.activityResource.labelConfigurator?.titleFontSize {
            titleLabel.font = UIFont(name: fontName, size: fontSize)
        }
        
        currentProgressLabel.isHidden   = true
        currentProgressLabel.text       = activity.currentProgress.cleanValue
        currentProgressLabel.textColor  = activity.activityResource.labelConfigurator?.textColor
        
        if let fontName = activity.activityResource.labelConfigurator?.currentProgressFontName, let fontSize = activity.activityResource.labelConfigurator?.currentProgressFontSize {
            currentProgressLabel.font = UIFont(name: fontName, size: fontSize)
        }
        
        goalLabel.isHidden              = true
        goalLabel.text                  = "Your goal is \(activity.goal.cleanValue)"
        goalLabel.textColor             = activity.activityResource.labelConfigurator?.textColor
        
        if let fontName = activity.activityResource.labelConfigurator?.goalFontName,
            let fontSize = activity.activityResource.labelConfigurator?.goalLabelFontSize {
            goalLabel.font = UIFont(name: fontName, size: fontSize)
        }
        
        progressGradientImageView.image     = activity.activityResource.gradientImage
        
        helperViewBottomConstraint.constant = min(CGFloat(activity.currentProgress / activity.goal) * frame.height, frame.height)
    }
    
    fileprivate func configureViewsAfterFlip() {
        titleLabel.isHidden             = false
        currentProgressLabel.isHidden   = false
        goalLabel.isHidden              = false
    }
}
