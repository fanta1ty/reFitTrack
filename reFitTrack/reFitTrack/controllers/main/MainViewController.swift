//
//  MainViewController.swift
//  reFitTrack
//
//  Created by trekvn on 11/8/18.
//  Copyright © 2018 Thinh Nguyen. All rights reserved.
//

import UIKit
//TableView
fileprivate let tableHeaderSectionViewHeight: CGFloat       = 114.0
fileprivate let tableCellHeight: CGFloat                    = 105.0
fileprivate let tableHeaderSectionViewHeightDelta: CGFloat  = 64.0
fileprivate let rowsCount                                   = 10

//Others
fileprivate let animationDuration: TimeInterval     = 0.3
fileprivate let maxHeaderSectionAlphaValue: CGFloat = 0.95
fileprivate let cornerRadius: CGFloat               = 12.0
fileprivate let ratioCoEfficient: CGFloat           = 3.117

fileprivate enum HeaderSectionState {
    case visible
    case unvisible
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var helperView: UIView!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var activityTableView: UITableView!
    
    @IBOutlet weak var activityTableViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var activityTableViewLeadingConstraint: NSLayoutConstraint!
    
    fileprivate var backgroundHeaderSectionView: UIView!
    fileprivate var tableHeaderSectionView: TableHeaderSectionView!
    fileprivate var headerSectionState = HeaderSectionState.unvisible
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configuration()
    }
}
//MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerSection = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderSectionView.identifier) as! TableHeaderSectionView
        
        backgroundHeaderSectionView.backgroundColor = .clear
        tableHeaderSectionView = headerSection
        tableHeaderSectionView.backgroundView = backgroundHeaderSectionView
        
        return headerSection
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableHeaderSectionViewHeight
    }
}

//MARK: Functions
extension MainViewController {
    fileprivate func configuration() {
        backgroundHeaderSectionView = UIView(frame: helperView.frame)
        
        configureTableView()
    }
    
    fileprivate func configureTableView() {
        var nib = UINib(nibName: TableHeaderSectionView.identifier, bundle: nil)
        activityTableView.register(nib, forHeaderFooterViewReuseIdentifier: TableHeaderSectionView.identifier)
    }
}
