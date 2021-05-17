//
//  Protocols.swift
//  OpenTweet
//
//  Created by Sherman Shi on 5/16/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import Foundation

protocol TransitionToTimelineDetailViewControllerDelegate: AnyObject {
    func presentDetailViewController(with timelineTweet: TimelineTweet)
}
