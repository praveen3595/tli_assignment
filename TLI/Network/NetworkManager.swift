//
//  NetworkManager.swift
//  TLI
//
//  Created by Praveen Singh on 26/11/18.
//  Copyright © 2018 Praveen Singh. All rights reserved.
//

import Foundation

/**
 NetworkManager - Resposible for fetching data from remote server
 */
struct NetworkManager {
    
    static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()

    static func fetchNYTNews(with url: URL, completion: @escaping (Data) -> Void) {
        let request = URLRequest(url: url)
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.waitsForConnectivity = true
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let error = error {
                fatalError("Network error\(error.localizedDescription) on NetworkManagerclass line 24")
            } else if let data = data {
                print("response = ",response ?? "")
                completion(data)
            } else {
                fatalError("Some Network Error on  NetworkManagerclass line 29")
            }
        })
        task.resume()
    }
}
