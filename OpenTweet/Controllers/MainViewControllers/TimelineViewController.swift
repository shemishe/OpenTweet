//
//  TimelineViewController.swift
//  OpenTweet
//
//  Created by Sherman Shi on 5/15/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    // MARK: - Properties
    
    let tableView: TimelineTableView = {
        let tv = TimelineTableView()
        return tv
    }()
    
    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        configureNavBar()
        configureTableView()
    }

    // MARK: - Helper Functions

    private func configureTableView() {
        tableView.transitionToTimelineDetailViewControllerDelegate = self
        tableView.alertDelegate = self
        
        view.addSubview(tableView)
        tableView.anchorWithConstant(top: view.safeAreaLayoutGuide.topAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     leading: view.leadingAnchor,
                                     trailing: view.trailingAnchor,
                                     paddingTop: 0,
                                     paddingBottom: 0,
                                     paddingLeading: 0,
                                     paddingTrailing: 0,
                                     width: 0,
                                     height: 0)
    }
    
    private func configureNavBar() {
        // OpenTable icon centered in navigation bar
        navigationItem.titleView = UIImageView(image: K.Images.openTable)
        navigationItem.titleView?.contentMode = .scaleAspectFit
    }
}

// MARK: - Parsing JSON

extension TimelineViewController {
    private func parseJSON() {
        guard let jsonPath = Bundle.main.path(forResource: K.JSON.timeline, ofType: K.JSON.json) else {
            Alert.showDefaultAlert(title: "Error", message: "No JSON data exists", vc: self)
            return
        }
        
        let jsonURL = URL(fileURLWithPath: jsonPath)
        
        do {
            let jsonData = try Data(contentsOf: jsonURL)
            tableView.timelineData = try JSONDecoder().decode(TimelineData.self, from: jsonData)
        } catch {
            print("catch block error")
            print(error)
        }
    }
}


// MARK: - Timeline Detail View Controller Delegate

extension TimelineViewController: TransitionToTimelineDetailViewControllerDelegate {
    func presentDetailViewController(with timelineTweet: TimelineTweet) {
        let vc = TimelineDetailViewController()
        vc.timelineTweet = timelineTweet
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Alert Delegate

extension TimelineViewController: AlertDelegate {
    func showAlert(with userToBlock: String) {
        Alert.showBlockAlert(title: "Block \(userToBlock)",
                             message: "\(userToBlock) will no longer be able to follow or reply to you, you will not see activity from this user.",
                             vc: self)
    }
}
