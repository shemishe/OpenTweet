//
//  TimelineTableViewCell.swift
//  OpenTweet
//
//  Created by Sherman Shi on 5/15/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit
import LinkPresentation

class TimelineTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "TimelineTableViewCell"
    
    // MARK: - Properties
    
    lazy var avatar: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = K.Colors.white
        iv.layer.borderWidth = 1
        iv.layer.borderColor = K.Colors.mainAppColor.cgColor
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var username: UILabel = {
        let label = UILabel()
        label.textColor = K.Colors.mainAppColor
        return label
    }()
    
    lazy var timestamp: UILabel = {
        let label = UILabel()
        label.textColor = K.Colors.black
        return label
    }()
    
    lazy var content: UILabel = {
        let label = UILabel()
        label.textColor = K.Colors.black
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewCellComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Helper Functions
    
    private func configureViewCellComponents() {
        backgroundColor = K.Colors.white

        let defaultPadding = K.Layout.defaultSidePadding()
        let halfPadding: CGFloat = 8
        let avatarSize: CGFloat = 50
        
        addSubview(avatar)
        avatar.anchorWithConstant(top: topAnchor,
                                  bottom: nil,
                                  leading: leadingAnchor,
                                  trailing: nil,
                                  paddingTop: halfPadding,
                                  paddingBottom: 0,
                                  paddingLeading: defaultPadding,
                                  paddingTrailing: 0,
                                  width: avatarSize,
                                  height: avatarSize)
        avatar.layer.cornerRadius = avatarSize / 2
        
        addSubview(username)
        username.anchorWithConstant(top: avatar.topAnchor,
                                    bottom: nil,
                                    leading: avatar.trailingAnchor,
                                    trailing: trailingAnchor,
                                    paddingTop: 0,
                                    paddingBottom: 0,
                                    paddingLeading: halfPadding,
                                    paddingTrailing: defaultPadding,
                                    width: 0,
                                    height: 0)
        
        addSubview(timestamp)
        timestamp.anchorWithConstant(top: username.bottomAnchor,
                                     bottom: nil,
                                     leading: username.leadingAnchor,
                                     trailing: username.trailingAnchor,
                                     paddingTop: halfPadding,
                                     paddingBottom: 0,
                                     paddingLeading: 0,
                                     paddingTrailing: 0,
                                     width: 0,
                                     height: 0)
        
        addSubview(content)
        content.anchorWithConstant(top: timestamp.bottomAnchor,
                                   bottom: bottomAnchor,
                                   leading: username.leadingAnchor,
                                   trailing: username.trailingAnchor,
                                   paddingTop: halfPadding,
                                   paddingBottom: halfPadding,
                                   paddingLeading: 0,
                                   paddingTrailing: 0,
                                   width: 0,
                                   height: 0)
    }
}

// MARK: - Cell Configuration With Timeline Data

extension TimelineTableViewCell {
    
    func configureCell(with timelineTweet: TimelineTweet) {
        username.text = timelineTweet.author
        timestamp.text = timestampConverter(timestamp: timelineTweet.date)
        content.text = timelineTweet.content
        
        // If timeline tweet data contains avatar data, parse image data, otherwise use default image
        if timelineTweet.avatar != nil {
            guard let avatarURLString = timelineTweet.avatar else { return }
            guard let avatarURL = URL(string: avatarURLString) else { return }
            avatar.downloadImage(from: avatarURL)
        } else {
            avatar.image = K.Images.openTable
        }
    }
}
