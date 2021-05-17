//
//  TimelineDetailViewController.swift
//  OpenTweet
//
//  Created by Sherman Shi on 5/16/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class TimelineDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var timelineTweet: TimelineTweet?
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureViewComponents()
        print("this is the tweet \(timelineTweet)")
    }
    
    // MARK: - Helper Functions
    
    private func configureViewComponents() {
        view.backgroundColor = K.Colors.white
    }
    
    private func configureNavBar() {
        navigationItem.title = "OpenTweet"
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainRed()]
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
    }
}
