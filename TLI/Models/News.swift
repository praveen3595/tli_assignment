//
//  News.swift
//  TLI
//
//  Created by Praveen Singh on 26/11/18.
//  Copyright © 2018 Praveen Singh. All rights reserved.
//

import Foundation

struct News {
    
    let newsTitle: String
    let newsDate: String
    let newsAuthor: String
    var newsImageUrl: URL
    let newsContent: String
    let id: Int
    
    init?(newsTitle: String, newsImageUrl: URL, newsDate: String, newsAuthor: String, newsContent: String, id: Int) {
        self.newsTitle = newsTitle
        self.newsDate = newsDate
        self.newsAuthor = newsAuthor
        self.newsImageUrl = newsImageUrl
        self.newsContent = newsContent
        self.id = id
        if newsDate.isEmpty  {
            return nil
        }
    }
    
    init?(newJson: [String: Any]) {
        guard
            let newsTitle = newJson["title"] as? String,
            let newsContent = newJson["abstract"] as? String,
            let newsAuthor = newJson["byline"] as? String,
            let id = newJson["id"] as? Int,
            let medias = newJson["media"] as? [[String: Any]],
            let newsDate = newJson["published_date"] as? String else {
                return nil
        }
        var _newsImageURL: URL!
        for media in medias {
            if let media_metadata = media["media-metadata"] as? [[String: Any]] {
                for imageJson in media_metadata {
                    if let thumbnail = imageJson["format"] as? String,
                        thumbnail == "Standard Thumbnail",
                        let urlSring = imageJson["url"] as? String,
                        let newsImageUrl = URL(string: urlSring){
                        _newsImageURL = newsImageUrl
                        break
                    }
                }
                if _newsImageURL == nil {return nil }
            }
        }
        self.newsImageUrl = _newsImageURL
        self.newsTitle = newsTitle
        self.newsDate = newsDate
        self.newsAuthor = newsAuthor
        self.newsContent = newsContent
        self.id = id
    }
}
