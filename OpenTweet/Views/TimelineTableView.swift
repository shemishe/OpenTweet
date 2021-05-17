//
//  TimelineTableView.swift
//  OpenTweet
//
//  Created by Sherman Shi on 5/15/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class TimelineTableView: UITableView {
    
    // MARK: - Properties
    
    weak var transitionToTimelineDetailViewControllerDelegate: TransitionToTimelineDetailViewControllerDelegate?
    weak var alertDelegate: AlertDelegate?
    
    var timelineData: TimelineData?
    
    // MARK: - Initializers
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    
    private func configureTableView() {
        delegate = self
        dataSource = self
        register(TimelineTableViewCell.self, forCellReuseIdentifier: TimelineTableViewCell.reuseIdentifier)
        register(TimelineLinkPreviewTableViewCell.self, forCellReuseIdentifier: TimelineLinkPreviewTableViewCell.reuseIdentifier)
        backgroundColor = K.Colors.white
        showsVerticalScrollIndicator = false
        
        let bgView = UIView()
        bgView.backgroundColor = K.Colors.white
        backgroundView = bgView
        tableFooterView = UIView()
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

/* Tableview Delegate and Data Source */
extension TimelineTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timelineData?.timeline.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let regularCell = tableView.dequeueReusableCell(withIdentifier: TimelineTableViewCell.reuseIdentifier, for: indexPath) as! TimelineTableViewCell
        let linkPreviewCell = tableView.dequeueReusableCell(withIdentifier: TimelineLinkPreviewTableViewCell.reuseIdentifier, for: indexPath) as! TimelineLinkPreviewTableViewCell
        
        if let timelineData = timelineData?.timeline[indexPath.row] {
            let hyperlink = linkCheck(with: timelineData.content)
            
            if hyperlink == nil {
                regularCell.configureCell(with: timelineData)
                return regularCell
            } else {
                linkPreviewCell.configureCellWithLinkPreview(with: timelineData, hyperlink: hyperlink)
                return linkPreviewCell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if let tweet = timelineData?.timeline[indexPath.row] {
            // Delegate method to trigger tweet detail transition
            transitionToTimelineDetailViewControllerDelegate?.presentDetailViewController(with: tweet)
        }
    }
}

// MARK: - Context Menus
extension TimelineTableView {
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let author = timelineData?.timeline[indexPath.row].author
        
        let config = UIContextMenuConfiguration(identifier: nil,
                                                previewProvider: nil) { _ in
            
            let likeAction = UIAction(title: "Like", image: K.Icons.like) { _ in
                print("I LIKE THIS")
            }

            let followAction = UIAction(title: "Follow", image: K.Icons.follow) { _ in
                print("I FOLLOWED THIS")
            }
            
            let saveFavoritesAction = UIAction(title: "Save to Favorites", image: K.Icons.saveFavorites) { _ in
                print("I SAVED THIS")
            }
            
            let blockAction = UIAction(title: "Block", image: K.Icons.block) { [weak self] _ in
                self?.alertDelegate?.showAlert(with: author ?? "User")
            }
            
            let reportAction  = UIAction(title: "Report this post", image: K.Icons.report) { _ in
                print("I REPORTED THIS")
            }
            
            let menu = UIMenu(title: "",
                              image: nil,
                              identifier: nil,
                              options: [],
                              children: [likeAction, followAction, saveFavoritesAction, blockAction, reportAction])
            
            return menu
        }
        
        return config
    }
//    
//    func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
//        <#code#>
//    }
}

// MARK: - Hyperlink Check

extension TimelineTableView {
    private func linkCheck(with contentString: String) -> URL? {
        let type: NSTextCheckingResult.CheckingType = .link
        let linkDetector = try? NSDataDetector(types: type.rawValue)
        
        var hyperlink: URL?
        
        if let detected = linkDetector {
            let matches = detected.matches(in: contentString, options: .reportCompletion, range: NSMakeRange(0, contentString.count))

            for match in matches {
                hyperlink = match.url
            }
        }
        return hyperlink
    }
}
