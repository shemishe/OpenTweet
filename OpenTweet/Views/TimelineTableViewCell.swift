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
    
    lazy var usernameButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(K.Colors.mainAppColor, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0.001, bottom: 0.001, right: 0)
        return button
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
    
    // MARK: - Closures
    
    var usernameButtonTapped: (() -> Void)?

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewCellComponents()
        configureButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Helper Functions
    
    func configureButtonActions() {
        usernameButton.addTarget(self, action: #selector(handleUsernameButtonTapped), for: .touchUpInside)
    }
    
    private func configureViewCellComponents() {
        backgroundColor = K.Colors.white

        let defaultPadding = K.Layout.defaultSidePadding()
        let halfPadding: CGFloat = 8
        let minimumPadding: CGFloat = 4
        let avatarSize: CGFloat = 50
        
        contentView.addSubview(avatar)
        avatar.anchorWithConstant(top:  contentView.topAnchor,
                                  bottom: nil,
                                  leading:  contentView.leadingAnchor,
                                  trailing: nil,
                                  paddingTop: halfPadding,
                                  paddingBottom: 0,
                                  paddingLeading: defaultPadding,
                                  paddingTrailing: 0,
                                  width: avatarSize,
                                  height: avatarSize)
        avatar.layer.cornerRadius = avatarSize / 2
        
        contentView.addSubview(usernameButton)
        usernameButton.anchorWithConstant(top: avatar.topAnchor,
                                          bottom: nil,
                                          leading: avatar.trailingAnchor,
                                          trailing:  contentView.trailingAnchor,
                                          paddingTop: 0,
                                          paddingBottom: 0,
                                          paddingLeading: halfPadding,
                                          paddingTrailing: defaultPadding,
                                          width: 0,
                                          height: 0)
        
        contentView.addSubview(timestamp)
        timestamp.anchorWithConstant(top: usernameButton.bottomAnchor,
                                     bottom: nil,
                                     leading: usernameButton.leadingAnchor,
                                     trailing: usernameButton.trailingAnchor,
                                     paddingTop: minimumPadding,
                                     paddingBottom: 0,
                                     paddingLeading: 0,
                                     paddingTrailing: 0,
                                     width: 0,
                                     height: 0)
        
        contentView.addSubview(content)
        content.anchorWithConstant(top: timestamp.bottomAnchor,
                                   bottom:  contentView.bottomAnchor,
                                   leading: usernameButton.leadingAnchor,
                                   trailing: usernameButton.trailingAnchor,
                                   paddingTop: minimumPadding,
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
        usernameButton.setTitle(timelineTweet.author, for: .normal)
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

// MARK: - Selectors

extension TimelineTableViewCell {
    @objc func handleUsernameButtonTapped() {
        usernameButtonTapped?()
    }
}
