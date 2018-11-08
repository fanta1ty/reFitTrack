//
//  UIViewExtensions.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func frameX() -> CGFloat {
        return self.frame.origin.x
    }
    
    func frameY() -> CGFloat {
        return self.frame.origin.y
    }
    
    func frameWidth() -> CGFloat {
        return self.frame.width
    }
    
    func frameHeight() -> CGFloat {
        return self.frame.height
    }
    
    func roundSpecificCorners(corners: UIRectCorner, cornerRadius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    func xibSetup(subview: inout UIView?, nibName: String) {
        subview = loadViewFromNib(nibName: nibName)
        subview!.frame = bounds
        subview!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(subview!)
    }
    
    private func loadViewFromNib(nibName: String) -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}
