//
//  NetworkManager.swift
//  OpenTweet
//
//  Created by Sherman Shi on 5/17/21.
//  Copyright © 2021 OpenTable, Inc. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    // Typealias completions with result & error handlers
    public typealias TimelineJSONParseCompletion = (Result<TimelineData, JSONError>) -> Void
    public typealias ImageDownloadCompletion = (Result<UIImage?, JSONError>) -> Void
    
    private init() {}
    
    func fetchTimelineTweets(from url: URL, completion: @escaping TimelineJSONParseCompletion) {
        do {
            let jsonData = try Data(contentsOf: url)
            let timelineData = try JSONDecoder().decode(TimelineData.self, from: jsonData)
            
            completion(.success(timelineData))
            
//            for tweet in timelineData.timeline {
//                if let avatarURL = tweet.avatar {
//                    print(avatarURL)
//                }
//            }
        } catch {
            completion(.failure(.noDataError))
        }
    }
    
    func fetchAvatarImages(from url: URL, completion: @escaping ImageDownloadCompletion) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let _ = error else {
                completion(.failure(.genericError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataError))
                return
            }
        
            let image = UIImage(data: data)
            completion(.success(image))
        }.resume()
    }
}
