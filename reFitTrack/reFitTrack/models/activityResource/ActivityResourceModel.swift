//
//  ActivityResourceModel.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

struct ActivityResourceModel {
    let normalActivityButtonImage: UIImage!
    let selectedActivityButtonImage: UIImage!
    let gradientImage: UIImage!
    let labelConfigurator: LabelConfiguratorModel?
    
    public init(normalActivityButtonImage: UIImage,
                selectedActivityButtonImage: UIImage,
                gradientImage: UIImage,
                labelConfigurator: LabelConfiguratorModel? = nil) {
        
        self.normalActivityButtonImage      = normalActivityButtonImage
        self.selectedActivityButtonImage    = selectedActivityButtonImage
        self.gradientImage                  = gradientImage
        self.labelConfigurator              = labelConfigurator
    }
}
