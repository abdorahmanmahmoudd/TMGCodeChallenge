//
//  Request.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 8/14/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

public enum DataType {
    case JSON
    case data
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

public protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}
