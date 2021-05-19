//
//  TimelineDetailTableView.swift
//  OpenTweet
//
//  Created by Sherman Shi on 5/18/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

enum TweetThread: Int, CaseIterable {
    case MainTweet
}

class TimelineDetailTableView: UITableView {

    // MARK: - Properties
    
    weak var transitionToUserProfileViewControllerDelegate: TransitionToUserProfileViewControllerDelegate?

    var timelineDetailData: TimelineData?
    var mainTweet: TimelineTweet?
    var replyTweets: [TimelineTweet]?
    
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
        register(TimelineDetailTableViewCell.self, forCellReuseIdentifier: TimelineDetailTableViewCell.reuseIdentifier)
        backgroundColor = K.Colors.white
        showsVerticalScrollIndicator = false
        
        let bgView = UIView()
        bgView.backgroundColor = K.Colors.white
        backgroundView = bgView
        tableFooterView = UIView()
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // Top separator line for first cell
        let pixel = 1 / UIScreen.main.scale
        let line = UIView(frame: CGRect(x: 0, y: 0, width: K.Layout.screenWidth, height: pixel))
        tableHeaderView = line
        line.backgroundColor = separatorColor
    }
}

// MARK: - TableView Delegate and Data Source

extension TimelineDetailTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + (replyTweets?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mainCell = tableView.dequeueReusableCell(withIdentifier: TimelineDetailTableViewCell.reuseIdentifier, for: indexPath) as! TimelineDetailTableViewCell
        let threadIndex = TweetThread(rawValue: indexPath.row)
        
        if let mainTweet = mainTweet,
           let replyTweets = replyTweets {
            switch threadIndex {
            case .MainTweet:
                mainCell.configureCell(with: mainTweet)
                mainCell.usernameButtonTapped = {
                    self.transitionToUserProfileViewControllerDelegate?.presentUserProfileViewController(with: mainTweet.author)
                }
            case .none:
                mainCell.configureCell(with: replyTweets[indexPath.row - 1])
                mainCell.usernameButtonTapped = {
                    self.transitionToUserProfileViewControllerDelegate?.presentUserProfileViewController(with: replyTweets[indexPath.row - 1].author)
                }
            }
        }
        return mainCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
