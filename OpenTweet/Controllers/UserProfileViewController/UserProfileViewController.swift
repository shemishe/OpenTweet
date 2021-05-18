//
//  UserProfileViewController.swift
//  OpenTweet
//
//  Created by Sherman Shi on 5/17/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    var username: String?
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureViewComponents()
    }
    
    // MARK: - Helper Functions
    
    private func configureNavBar() {
        navigationItem.title = username
    }
    private func configureViewComponents() {
        view.backgroundColor = .blue
    }
}
