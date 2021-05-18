//
//  SearchViewController.swift
//  OpenTweet
//
//  Created by Sherman Shi on 5/15/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureViewComponents()
    }
    
    // MARK: - Helper Functions
    
    private func configureViewComponents() {
        
    }
    
    private func configureNavBar() {
        navigationItem.title = "Search"
        let textAttributes = [NSAttributedString.Key.foregroundColor: K.Colors.mainAppColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}
