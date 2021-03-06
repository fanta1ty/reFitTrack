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
fileprivate let maxHeaderSectionAlphaValue: CGFloat = 1.0
fileprivate let cornerRadius: CGFloat               = 12.0
fileprivate let ratioCoEfficient: CGFloat           = 3.117

fileprivate enum HeaderSectionState {
    case visible
    case unvisible
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var helperView: UIView!
    @IBOutlet weak var animationView: AnimationView!
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureAnimationView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.animationView.performAnimation()
        }
    }
}
//MARL: ScrollViewDelegate
extension MainViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            animationView.alpha = 1 - scrollView.contentOffset.y / animationView.frameHeight()
            helperView.alpha    = min(1 - animationView.alpha, maxHeaderSectionAlphaValue)
            
            if animationView.alpha <= 0 && headerSectionState == HeaderSectionState.unvisible {
                backgroundHeaderSectionView.backgroundColor = helperView.backgroundColor
                tableHeaderSectionView.backgroundView = backgroundHeaderSectionView
                headerSectionState = HeaderSectionState.visible
            } else if animationView.alpha > 0 && headerSectionState == HeaderSectionState.visible {
                backgroundHeaderSectionView.backgroundColor = .clear
                tableHeaderSectionView.backgroundView = backgroundHeaderSectionView
                headerSectionState = HeaderSectionState.unvisible
            }
            
        } else {
            animationView.alpha = 1
            helperView.alpha    = 0
        }
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let activityTableViewCell = cell as! ActivityTableViewCell
        
        if indexPath.row == 0 {
            activityTableViewCell.setBackgroundImage(image: UIImage(named: MainScreenImageConstants.whiteBackgroundTop.rawValue))
        } else if indexPath.row == rowsCount - 1 {
            activityTableViewCell.setBackgroundImage(image: UIImage(named: MainScreenImageConstants.whiteBackgroundBottom.rawValue))
            cell.clipsToBounds = true
        } else {
            activityTableViewCell.setBackgroundImage(image: UIImage(named: MainScreenImageConstants.whiteBackgroundMiddle.rawValue))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableHeaderSectionViewHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableCellHeight
    }
}

//MARK: UITableViewDatasource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identifier, for: indexPath)
        return cell
    }
}

//MARK: Private Functions
extension MainViewController {
    fileprivate func configuration() {
        backgroundHeaderSectionView = UIView(frame: helperView.frame)
        animationView.frame = CGRect(x: view.frameX(),
                                     y: view.frameY(),
                                     width: view.frameWidth() - activityTableViewLeadingConstraint.constant + activityTableViewTrailingConstraint.constant,
                                     height: view.frameHeight())
        
        configureTitleView()
        configureTableView()
    }
    
    fileprivate func configureTitleView() {
        let logo                    = UIImage(named: MainScreenImageConstants.title.rawValue)
        let titleView               = UIImageView(image: logo)
        navigationItem.titleView    = titleView
    }
    
    fileprivate func configureTableView() {
        var nib = UINib(nibName: TableHeaderSectionView.identifier, bundle: nil)
        activityTableView.register(nib, forHeaderFooterViewReuseIdentifier: TableHeaderSectionView.identifier)
        
        nib = UINib(nibName: ActivityTableViewCell.identifier, bundle: nil)
        activityTableView.register(nib, forCellReuseIdentifier: ActivityTableViewCell.identifier)
    }
    
    fileprivate func configureAnimationView() {
        let activities = ActivityDataProvider.generateActivities()
        animationView.configureSubviews(activities: activities)
        animationView.animationFirstPhaseDidFinish = {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(animationDuration)
            
            self.animationView.frame = CGRect(x: 0, y: 0, width: self.animationView.frameWidth(),
                                              height: self.animationView.frameHeight() - (self.animationView.frameHeight() / ratioCoEfficient) - tableHeaderSectionViewHeightDelta)
            self.activityTableView.tableHeaderView = self.animationView
            self.navigationController!.isNavigationBarHidden = false
            
            UIView.commitAnimations()
        }
    }
}
