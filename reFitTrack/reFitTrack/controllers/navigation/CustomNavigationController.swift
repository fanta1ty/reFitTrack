//
//  CustomNavigationController.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
}

extension CustomNavigationController {
    fileprivate func configureNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        isNavigationBarHidden = true
    }
}
