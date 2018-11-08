//
//  SegmentView.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit

fileprivate let segmentViewCornerRadius: CGFloat    = 13.0
fileprivate let segmentViewBorderWidth: CGFloat     = 1.0

class SegmentView: UIView {
    fileprivate let buttonOvalLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        configuration()
    }
}

//MARK: Public functions
extension SegmentView {
    func setIndicatorPosition(position: CGFloat) {
        buttonOvalLayer.position = CGPoint(x: position, y: bounds.origin.y)
    }
}

//MARK: Private functions
extension SegmentView {
    fileprivate func configuration() {
        layer.cornerRadius  = segmentViewCornerRadius
        layer.borderWidth   = segmentViewBorderWidth
        layer.borderColor   = UIColor.white.cgColor
        
        //Create button oval layer
        let ovalHeight  = bounds.height
        let ovalWidth   = bounds.width / 2
        let ovalPath    = UIBezierPath(roundedRect: CGRect(x: 0,
                                                           y: 0,
                                                           width: ovalWidth,
                                                           height: ovalHeight),
                                       cornerRadius: segmentViewCornerRadius)
        
        buttonOvalLayer.path        = ovalPath.cgPath
        buttonOvalLayer.fillColor   = UIColor.white.cgColor
        
        layer.addSublayer(buttonOvalLayer)
    }
}
