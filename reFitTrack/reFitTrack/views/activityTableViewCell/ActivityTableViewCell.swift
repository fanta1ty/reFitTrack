//
//  ActivityTableViewCell.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    static let identifier = "ActivityTableViewCell"
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    func setBackgroundImage(image: UIImage?) {
        guard let image = image else {
            return
        }
        
        backgroundImageView.image = image
    }
}
