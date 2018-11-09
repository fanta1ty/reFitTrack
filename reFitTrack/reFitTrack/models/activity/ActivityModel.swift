//
//  ActivityModel.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import Foundation

struct ActivityModel {
    let title: String!
    let goal: Float!
    let currentProgress: Float!
    let activityResource: ActivityResourceModel!
    
    init(title: String, goal: Float, currentProgress: Float, activityResource: ActivityResourceModel) {
        self.title              = title
        self.goal               = goal
        self.currentProgress    = currentProgress
        self.activityResource   = activityResource
    }
}
