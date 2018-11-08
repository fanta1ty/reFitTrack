//
//  TableHeaderSectionView.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit
fileprivate let startIndicatorPosition: CGFloat = 0.0

class TableHeaderSectionView: UITableViewHeaderFooterView {
    static let identifier: String = "TableHeaderSectionView"
    
    @IBOutlet weak var segmentView: SegmentView!
    @IBOutlet weak var timelineButton: UIButton!
    @IBOutlet weak var statisticsButton: UIButton!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        configuration()
    }
}

//MARK: Actions
extension TableHeaderSectionView {
    @IBAction func onTimelineButton(_ sender: Any) {
        timelineButton.isSelected   = true
        statisticsButton.isSelected = false
        
        segmentView.setIndicatorPosition(position: startIndicatorPosition)
    }
    
    @IBAction func onStatisticsButton(_ sender: Any) {
        timelineButton.isSelected   = false
        statisticsButton.isSelected = true
        
        segmentView.setIndicatorPosition(position: statisticsButton.bounds.width)
    }
}

//MARK: Private functions
extension TableHeaderSectionView {
    fileprivate func configuration() {
        timelineButton.setTitleColor(.white,
                                     for: .normal)
        timelineButton.setTitleColor(.activeSegmentButtonFontBackgroundColor(),
                                     for: .selected)
        
        statisticsButton.setTitleColor(.white,
                                       for: .normal)
        statisticsButton.setTitleColor(.activeSegmentButtonFontBackgroundColor(),
                                       for: .selected)
        
        timelineButton.isSelected   = true
        statisticsButton.isSelected = false
    }
}
