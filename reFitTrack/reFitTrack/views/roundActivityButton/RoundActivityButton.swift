//
//  RoundActivityButton.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit

class RoundActivityButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = frameHeight() / 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = frameHeight() / 2
    }
}
