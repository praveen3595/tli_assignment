//
//  NewsStore.swift
//  TLI
//
//  Created by Praveen Singh on 26/11/18.
//  Copyright © 2018 Praveen Singh. All rights reserved.
//

import UIKit

/**
 ImageResult - Holds image from API
 */
enum ImageResult {
    case success(UIImage)
    case failure(String)
}

/**
 NewsResult - Holds News data from API
 */
enum NewsResult {
    case success([News])
    case failure(Error)
}

/**
 NewsStore - Important Class acts as Interface for providing data from any viewcontroller
 */
struct NewsStore {
    
    func fetchNews(for endPoint: EndPoint, completion: @escaping (NewsResult) -> Void) {
        switch endPoint {
        case .mostviewedNews:
            let url = NYTimesAPI.nytimesURL(for: .mostviewedNews)
            NetworkManager.fetchNYTNews(with: url, completion: { (data) in
                let finalNews = NYTimesAPI.processNews(fromJSON: data)
                completion(finalNews)
            })
        }
    }
    
    func fetchImage(for news: News, completion: @escaping (ImageResult) -> Void) {
        let url = news.newsImageUrl
        NetworkManager.fetchNYTNews(with: url, completion: { (data) in
            let finalImage = NYTimesAPI.processImage(fromJSON: data)
            completion(finalImage)
        })
    }
}
