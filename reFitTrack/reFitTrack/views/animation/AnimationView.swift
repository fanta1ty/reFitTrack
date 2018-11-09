//
//  AnimationView.swift
//  reFitTrack
//
//  Created by trekvn on 11/9/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit

fileprivate let ratioItemWidthToGap: CGFloat                = 3.42
fileprivate let dropButtonsPositionCoefficient: CGFloat     = 1.08
fileprivate let finalButtonsPositionCoefficient: CGFloat    = 1.06
fileprivate let transformScale: CGFloat                     = 0.3

//Animation
fileprivate let animateDropDuration: TimeInterval   = 0.3
fileprivate let animateDropDumping: CGFloat         = 0.7
fileprivate let animateDropVelocity: CGFloat        = 0.5

fileprivate let animateExtendDistanceDuration: TimeInterval = 0.2
fileprivate let animateExtendDistanceDelay: TimeInterval    = 0.0

fileprivate let animateCollectActivitiesDuration: TimeInterval  = 0.25
fileprivate let animateCollectActivitiesDelay: TimeInterval     = 0.0

fileprivate let animateScaleFirstButtonDuration: TimeInterval   = 0.2
fileprivate let animateScaleFirstButtonDelay: TimeInterval      = 0.0
fileprivate let animateScaleFirstButtonCoefficient: CGFloat     = 1.33

fileprivate let animateMoveDuration: TimeInterval   = 0.4
fileprivate let animateMoveDelay: TimeInterval      = 0.0

fileprivate let animateScaleDuration: TimeInterval  = 1.0
fileprivate let animateScaleDelay: TimeInterval     = 0.0
fileprivate let animateScaleDumping: CGFloat        = 0.3
fileprivate let animateScaleVelocity: CGFloat       = 0.7

fileprivate let animateMoveFinalPositionDuration: TimeInterval  = 0.3
fileprivate let animateMoveFinalPositionDelay: TimeInterval     = 0.1

class AnimationView: UIView {
    static let identifier = "AnimationView"
    
    @IBOutlet weak var activityContainerView: ActivityContainerView!
    
    var animationFirstPhaseDidFinish: (() -> ())?
    var animationDidFinish: (() -> ())?
    
    //Fake button to determine the final position
    fileprivate var centerActivityRoundButton: RoundActivityButton?
    fileprivate var centerActivityRoundButtonIndex: Int = 0
    
    fileprivate var activities: [ActivityModel]?
    fileprivate var activitiesCount: Int!
    fileprivate var roundActivityButtons = [RoundActivityButton]()
    fileprivate var gapBetweenActivityButtons: CGFloat  = 0.0
    fileprivate var realActivityButtonWidth: CGFloat    = 0.0
    fileprivate var currentActiveRoundButtonTag         = 0
    
    fileprivate var subview: UIView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup(subview: &subview, nibName: AnimationView.identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(subview: &subview, nibName: AnimationView.identifier)
    }
}
//MARK: Actions
extension AnimationView {
    @objc func onRoundButton(roundButton: RoundActivityButton!) {
        if roundButton.isSelected == false {
            roundButton.isSelected = true
            
            let currentActiveRoundButton = roundActivityButtons[currentActiveRoundButtonTag]
            currentActiveRoundButton.isSelected = false
            currentActiveRoundButtonTag = roundButton.tag
            activityContainerView.flipView(activity: activities![currentActiveRoundButtonTag])
        }
    }
}

//MARK: Public Functions
extension AnimationView {
    func performAnimation() {
        animateDrop()
    }
    
    func configureSubviews(activities: [ActivityModel]) {
        self.activitiesCount    = activities.count
        self.activities         = activities
        
        if self.activitiesCount > 0 {
            createAndSetStartPositionRoundActivityButtons()
            activityContainerView.flipView(activity: activities.first!)
        }
    }
}

//MARK: Private Functions
extension AnimationView {
    fileprivate func createAndSetStartPositionRoundActivityButtons() {
        let allContentWidth = bounds.width
        let buttonWidth     = allContentWidth / CGFloat(activitiesCount)
        
        gapBetweenActivityButtons = buttonWidth / ratioItemWidthToGap
        
        let deltaWidth      = gapBetweenActivityButtons / CGFloat(activitiesCount)
        
        realActivityButtonWidth = buttonWidth - deltaWidth - gapBetweenActivityButtons
        
        centerActivityRoundButton = RoundActivityButton(frame: CGRect(x: 0,
                                                                      y: 0,
                                                                      width: realActivityButtonWidth * animateScaleFirstButtonCoefficient,
                                                                      height: realActivityButtonWidth * animateScaleFirstButtonCoefficient))
        centerActivityRoundButton!.backgroundColor = .clear
        centerActivityRoundButton!.center = CGPoint(x: bounds.width / 2,
                                                    y: (bounds.height / 2) / dropButtonsPositionCoefficient)
        centerActivityRoundButtonIndex = activitiesCount % 2 == 0 ? -1 : activitiesCount / 2
        currentActiveRoundButtonTag = 0
        
        addSubview(centerActivityRoundButton!)
        
        for index in 0..<activitiesCount {
            let startFrame = CGRect(x: gapBetweenActivityButtons + (gapBetweenActivityButtons + realActivityButtonWidth) * CGFloat(index),
                                    y: -realActivityButtonWidth - realActivityButtonWidth / 2,
                                    width: realActivityButtonWidth,
                                    height: realActivityButtonWidth)
            
            let activity = activities![index]
            
            let normalStateImage    = activity.activityResource.normalActivityButtonImage
            let selectedStateImage  = activity.activityResource.selectedActivityButtonImage
            
            let roundButton = RoundActivityButton(frame: startFrame)
            roundButton.setBackgroundImage(normalStateImage, for: .normal)
            roundButton.setBackgroundImage(selectedStateImage, for: [.highlighted, .selected])
            roundButton.isUserInteractionEnabled = false
            roundButton.tag = index
            roundButton.addTarget(self, action: #selector(onRoundButton(roundButton:)), for: .touchUpInside)
            
            roundActivityButtons.append(roundButton)
            subview?.addSubview(roundButton)
        }
        
        subview?.bringSubviewToFront(roundActivityButtons.first!)
        
        activityContainerView.transform = CGAffineTransform(scaleX: transformScale,
                                                            y: transformScale)
        subview?.bringSubviewToFront(activityContainerView)
    }
    
    //Animation
    fileprivate func animateDrop() {
        struct Counter {
            static var index = 0
        }
        
        if Counter.index == roundActivityButtons.count {
            animateExtendDistance()
            return
        }
        
        let roundActivityButton = roundActivityButtons[Counter.index]
        let delay: TimeInterval = Counter.index == 0 ? 1 : 0
        UIView.animate(withDuration: animateDropDuration, delay: delay, usingSpringWithDamping: animateDropDumping, initialSpringVelocity: animateDropVelocity, options: .curveLinear, animations: {
            let changedFrame = CGRect(x: roundActivityButton.frameX(),
                                      y: (self.bounds.height / 2) / dropButtonsPositionCoefficient - roundActivityButton.frameHeight() / 2,
                                      width: roundActivityButton.frameWidth(),
                                      height: roundActivityButton.frameHeight())
            
            roundActivityButton.frame = changedFrame
        }) { _ in
            Counter.index += 1
            self.animateDrop()
        }
    }
    
    fileprivate func animateExtendDistance() {
        UIView.animate(withDuration: animateExtendDistanceDuration, delay: animateExtendDistanceDelay, options: .curveLinear, animations: {
            for index in 0..<self.activitiesCount {
                if index == self.centerActivityRoundButtonIndex {
                    continue
                }
                
                let roundActivityButton = self.roundActivityButtons[index]
                let originDeltaX: CGFloat = (self.activitiesCount / (index + 1)) < 2
                    ? -self.gapBetweenActivityButtons / 2 : self.gapBetweenActivityButtons / 2
                
                let changedFrame = CGRect(x: roundActivityButton.frameX() - originDeltaX,
                                          y: roundActivityButton.frame.origin.y,
                                          width: roundActivityButton.frameWidth(),
                                          height: roundActivityButton.frameHeight())
                
                roundActivityButton.frame = changedFrame
            }
        }) { _ in
            self.animateCollect()
        }
    }
    
    fileprivate func animateCollect() {
        UIView.animate(withDuration: animateCollectActivitiesDuration, delay: animateCollectActivitiesDelay, options: .curveEaseIn, animations: {
            for index in 0..<self.activitiesCount {
                if index == self.centerActivityRoundButtonIndex {
                    // the number is odd then the central position of the index does not change
                    continue
                }
                let roundActivityButton = self.roundActivityButtons[index]
                roundActivityButton.center = self.centerActivityRoundButton!.center
            }
        }) { _ in
            self.animationScaleFirstButton()
        }
    }
    
    fileprivate func animationScaleFirstButton() {
        UIView.animate(withDuration: animateScaleFirstButtonDuration, delay: animateScaleFirstButtonDelay, options: .curveLinear, animations: {
            // scale first item
            let roundActivityButton = self.roundActivityButtons[0]
            
            roundActivityButton.transform = CGAffineTransform(scaleX: animateScaleFirstButtonCoefficient,
                                                              y: animateScaleFirstButtonCoefficient)
        }) { _ in
            self.animateMoveToTop()
        }
    }
    
    fileprivate func animateMoveToTop() {
        UIView.animate(withDuration: animateMoveDuration, delay: animateMoveDelay, options: .curveEaseIn, animations: {
            for index in 0..<self.activitiesCount {
                let roundActivityButton     = self.roundActivityButtons[index]
                roundActivityButton.center  = self.activityContainerView.center
            }
        }) { _ in
            for index in 0..<self.activitiesCount {
                let roundActivityButton         = self.roundActivityButtons[index]
                roundActivityButton.isHidden    = true
            }
            // make first button frame as other buttons
            self.roundActivityButtons[0].frame = self.roundActivityButtons[1].frame
            self.animateScaleView()
            self.animateMoveToFinalPosition()
        }
    }
    
    fileprivate func animateScaleView() {
        guard roundActivityButtons.count > 0 else {
            return
        }
        
        let currentActiveRoundButton        = roundActivityButtons.first!
        currentActiveRoundButton.isSelected = true
        UIView.animate(withDuration: animateScaleDuration, delay: animateScaleDelay,  usingSpringWithDamping: animateScaleDumping, initialSpringVelocity: animateScaleVelocity, options: .curveEaseOut, animations: {
            self.activityContainerView.alpha = 1
            self.activityContainerView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { _ in
            self.animationFirstPhaseDidFinish?()
        }
    }
    
    fileprivate func animateMoveToFinalPosition() {
        UIView.animate(withDuration: animateMoveFinalPositionDuration, delay: animateMoveFinalPositionDelay, options: .curveEaseInOut, animations: {
            for index in 0..<self.activitiesCount {
                let roundActivityButton         = self.roundActivityButtons[index]
                roundActivityButton.isHidden    = false
                roundActivityButton.isUserInteractionEnabled = true
                let finalFrame = CGRect(x: self.gapBetweenActivityButtons + (self.gapBetweenActivityButtons + self.realActivityButtonWidth) * CGFloat(index),
                                        y: self.bounds.height / 2 * finalButtonsPositionCoefficient - roundActivityButton.frameHeight() / 2,
                                        width: self.realActivityButtonWidth,
                                        height: self.realActivityButtonWidth)
                roundActivityButton.frame = finalFrame
            }
        }, completion:nil)
    }
}
