//
//  MainTabBarController.swift
//  OpenTweet
//
//  Created by Sherman Shi on 5/15/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Properties
    
    private var timelineVC = TimelineViewController()
    private var searchVC = SearchViewController()
    private var ordersVC = OrderViewController()
    private var profileVC = ProfileViewController()
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        
        let timelineController = configureNavControllers(vc: timelineVC,
                                                         title: K.Navigation.timeline,
                                                         image: K.Icons.timeline)
        let searchController = configureNavControllers(vc: searchVC,
                                                       title: K.Navigation.search,
                                                       image: K.Icons.search)
        let ordersController = configureNavControllers(vc: ordersVC,
                                                       title: K.Navigation.order,
                                                       image: K.Icons.order)
        let profileController = configureNavControllers(vc: profileVC,
                                                        title: K.Navigation.profile,
                                                        image: K.Icons.profile)
        
        viewControllers = [timelineController, searchController, ordersController, profileController]
    }
    
    // MARK: - Helper Functions
    
    private func configureTabBar() {
        // Set delegate to self in order to get tab bar tap actions
        delegate = self
        tabBar.tintColor = K.Colors.mainAppColor
        tabBar.barTintColor = K.Colors.white
        tabBar.isTranslucent = false
    }
    
    private func configureNavControllers(vc: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.tintColor = K.Colors.mainAppColor
        navController.navigationBar.barTintColor = K.Colors.white
        navController.navigationBar.isTranslucent = false
        return navController
    }
}

// MARK: - Tapping Timeline Tab Bar Button Again
extension MainTabBarController {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // Get view controllers
        guard let viewControllers = viewControllers else { return false }
        // If view controller of tapped tab bar button matches current view controller, it's a second tap
        if viewController == viewControllers[selectedIndex] {
            // Get navigation controller and the first view controller in the stack
            if let navVC = viewController as? UINavigationController,
               let vc = navVC.viewControllers.first as? TimelineViewController {
                // If the first view controller is currently visible, scroll to top of table view
                if vc.isViewLoaded && vc.view.window != nil {
                    print("yes in view")
                    timelineVC.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            }
        }
        return true
    }
}
