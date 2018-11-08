//
//  LabelConfiguratorModel.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

struct LabelConfiguratorModel {
    let textColor: UIColor?
    
    let titleFontName: String?
    let titleFontSize: CGFloat?
    
    let currentProgressFontName: String?
    let currentProgressFontSize: CGFloat?
    
    let goalFontName: String?
    let goalLabelFontSize: CGFloat?
    
    init(textColor: UIColor,
         titleFontName: String,
         titleFontSize: CGFloat,
         currentProgressFontName: String,
         currentProgressFontSize: CGFloat,
         goalFontName: String,
         goalLabelFontSize: CGFloat) {
        
        self.textColor = textColor
        
        self.titleFontName = titleFontName
        self.titleFontSize = titleFontSize
        
        self.currentProgressFontName = currentProgressFontName
        self.currentProgressFontSize = currentProgressFontSize
        
        self.goalFontName       = goalFontName
        self.goalLabelFontSize  = goalLabelFontSize
    }
}
