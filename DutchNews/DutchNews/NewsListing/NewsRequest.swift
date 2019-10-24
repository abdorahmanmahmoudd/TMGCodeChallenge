//
//  NewsRequest.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 8/14/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

enum NewsRequest: Request{
    case fetchNews(country: String, apiKey: String, pageIndex: Int)
    
    var path: String {
        switch self {
        case .fetchNews:
            return "/v2/top-headlines?"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchNews:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case let .fetchNews(country: country, apiKey: apiKey, pageIndex: pageIndex):
            return ["country": country, "apiKey": apiKey, "page": pageIndex]
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .fetchNews:
            return nil
        }
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringCacheData
    }
}

