//
//  NYAPI.swift
//  TLI
//
//  Created by Praveen Singh on 26/11/18.
//  Copyright © 2018 Praveen Singh. All rights reserved.
//

import UIKit

enum EndPoint: String {
    case mostviewedNews = "mostpopular/v2/mostviewed/all-sections/7.json"
}

enum NYTAPIError: Error {
    case invalidJSONData
}

private let baseURLString = "https://api.nytimes.com/svc/"
private let apiKey = "ef848ca1c21741969bb0459ca8542b65"

/**
 NYTimesAPI - Class responsible for creating URL and validate API response
 */
struct NYTimesAPI {
    
    /**
     created url for provided endpoints
     */
    static func nytimesURL(for endPoint: EndPoint) -> URL {
        let urlString = baseURLString + endPoint.rawValue
        var components = URLComponents(string: urlString)!
        var queryItems = [URLQueryItem]()
        
        let baseParams = [
            "api_key": apiKey
        ]
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        components.queryItems = queryItems
        return components.url!
    }
    
    /**
     validates API response and returns valid data
     */
    static func processNews(fromJSON data: Data) -> NewsResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            guard
                let jsonDictionary = jsonObject as? [String:Any],
                let newsArray = jsonDictionary["results"] as? [[String:Any]] else {
                    // The JSON structure doesn't match our expectations
                    return .failure(NYTAPIError.invalidJSONData)
            }
            var finalnews = [News]()
            for newsJSON in newsArray {
                if let news = News(newJson: newsJSON) {
                    finalnews.append(news)
                }
            }
            if finalnews.isEmpty && !newsArray.isEmpty {
                // We weren't able to parse any of the photos.
                return .failure(NYTAPIError.invalidJSONData)
            }
            return .success(finalnews)
        } catch let error {
            return .failure(error)
        }
    }
    
    /**
     validates API image response and returns valid image
     */
    static func processImage(fromJSON data: Data) -> ImageResult {
        guard
            let image = UIImage(data: data) else {
                return .failure("Image Data Error")
        }
        return .success(image)
    }
}
