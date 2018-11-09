//
//  ActivityDataProvider.swift
//  reFitTrack
//
//  Created by trekvn on 11/9/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

struct ActivityDataProvider {
    static func generateActivities() -> [ActivityModel] {
        var activities = [ActivityModel]()
        
        // run activity
        let runLabelConfigurator = LabelConfiguratorModel(textColor: .runActivityColor(),
                                                          titleFontName: FontNameConstants.light.rawValue,
                                                          titleFontSize: 24,
                                                          currentProgressFontName: FontNameConstants.bold.rawValue,
                                                          currentProgressFontSize: 48,
                                                          goalFontName: FontNameConstants.light.rawValue,
                                                          goalLabelFontSize: 14)
        
        let runActivityResource = ActivityResourceModel(normalActivityButtonImage: UIImage(named: MainScreenImageConstants.runNormal.rawValue)!,
                                                        selectedActivityButtonImage: UIImage(named: MainScreenImageConstants.runActive.rawValue)!,
                                                        gradientImage: UIImage(named: MainScreenImageConstants.pinkGradient.rawValue)!,
                                                        labelConfigurator: runLabelConfigurator)
        
        let runActivity = ActivityModel(title: "Steps",
                                        goal: 1240,
                                        currentProgress: 200,
                                        activityResource: runActivityResource)
        
        activities.append(runActivity)
        
        // calories activity
        let caloriesLabelConfigurator = LabelConfiguratorModel(textColor: .caloriesActivityColor(),
                                                               titleFontName: FontNameConstants.light.rawValue,
                                                               titleFontSize: 24,
                                                               currentProgressFontName: FontNameConstants.bold.rawValue,
                                                               currentProgressFontSize: 48,
                                                               goalFontName: FontNameConstants.light.rawValue,
                                                               goalLabelFontSize: 14)
        
        let caloriesActivityResource = ActivityResourceModel(normalActivityButtonImage: UIImage(named: MainScreenImageConstants.calNormal.rawValue)!,
                                                             selectedActivityButtonImage: UIImage(named: MainScreenImageConstants.calActive.rawValue)!,
                                                             gradientImage: UIImage(named: MainScreenImageConstants.orangeGradient.rawValue)!,
                                                             labelConfigurator: caloriesLabelConfigurator)
        
        let caloriesActivity = ActivityModel(title: "Calories",
                                             goal: 2000,
                                             currentProgress: 1000,
                                             activityResource: caloriesActivityResource)
        activities.append(caloriesActivity)
        
        // distance activity
        let distanceLabelConfigurator = LabelConfiguratorModel(textColor: .distanceActivityColor(),
                                                               titleFontName: FontNameConstants.light.rawValue,
                                                               titleFontSize: 24,
                                                               currentProgressFontName: FontNameConstants.bold.rawValue,
                                                               currentProgressFontSize: 48,
                                                               goalFontName: FontNameConstants.light.rawValue,
                                                               goalLabelFontSize: 14)
        
        let distanceActivityResource = ActivityResourceModel(normalActivityButtonImage: UIImage(named: MainScreenImageConstants.disNormal.rawValue)!,
                                                             selectedActivityButtonImage: UIImage(named: MainScreenImageConstants.disActive.rawValue)!,
                                                             gradientImage: UIImage(named: MainScreenImageConstants.blueGradient.rawValue)!,
                                                             labelConfigurator: distanceLabelConfigurator)
        
        let distanceActivity = ActivityModel(title: "Miles",
                                             goal: 1.35,
                                             currentProgress: 0.9,
                                             activityResource: distanceActivityResource)
        
        activities.append(distanceActivity)
        
        // bike activity
        let bikeLabelConfigurator = LabelConfiguratorModel(textColor: .bikeActivityColor(),
                                                           titleFontName: FontNameConstants.light.rawValue,
                                                           titleFontSize: 24,
                                                           currentProgressFontName: FontNameConstants.bold.rawValue,
                                                           currentProgressFontSize: 48,
                                                           goalFontName: FontNameConstants.light.rawValue,
                                                           goalLabelFontSize: 14)
        
        let bikeActivityResource = ActivityResourceModel(normalActivityButtonImage: UIImage(named: MainScreenImageConstants.bikeNormal.rawValue)!,
                                                         selectedActivityButtonImage: UIImage(named: MainScreenImageConstants.bikeActive.rawValue)!,
                                                         gradientImage: UIImage(named: MainScreenImageConstants.greenGradient.rawValue)!,
                                                         labelConfigurator: bikeLabelConfigurator)
        
        let bikeActivity = ActivityModel(title: "Miles",
                                         goal: 2.5,
                                         currentProgress: 2,
                                         activityResource: bikeActivityResource)
        
        activities.append(bikeActivity)
        
        // sleep activity
        let sleepLabelConfigurator = LabelConfiguratorModel(textColor: .sleepActivityColor(),
                                                            titleFontName: FontNameConstants.light.rawValue,
                                                            titleFontSize: 24,
                                                            currentProgressFontName: FontNameConstants.bold.rawValue,
                                                            currentProgressFontSize: 48,
                                                            goalFontName: FontNameConstants.light.rawValue,
                                                            goalLabelFontSize: 14)
        
        let sleepActivityResource = ActivityResourceModel(normalActivityButtonImage: UIImage(named: MainScreenImageConstants.sleepNormal.rawValue)!,
                                                          selectedActivityButtonImage: UIImage(named: MainScreenImageConstants.sleepActive.rawValue)!,
                                                          gradientImage: UIImage(named: MainScreenImageConstants.purpleGradient.rawValue)!,
                                                          labelConfigurator: sleepLabelConfigurator)
        
        let sleepActivity = ActivityModel(title: "Hours",
                                          goal: 8,
                                          currentProgress: 5.5,
                                          activityResource: sleepActivityResource)
        
        activities.append(sleepActivity)
        
        return activities
    }
}
