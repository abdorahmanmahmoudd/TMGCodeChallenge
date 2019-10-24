//
//  APIClient.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/18/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

typealias Failure = (Error?) -> Void
typealias Success = (Codable?) -> Void

// MARK: This class  between Real and Mock API providers
final class APIClient {
    
    var apiProvider: API
    init(apiProvider: API = RealAPI()) {
        self.apiProvider = apiProvider
    }
}

// MARK: This protocol should be an interface for the APIs
protocol API {
//    func fetchNews(withCountry country: String, andPageIndex pageIndex: Int, success: @escaping NewsSuccess, failure: @escaping Failure)
    
    func fetch<T: Codable>(withRequest request: Request, model: T, success: @escaping Success, failure: @escaping Failure)
    
}

// MARK: This class should have the real implementation of the APIs
final class RealAPI: API{
    
//    func fetch<T: Decodable>(url: String, success: @escaping (T?) -> Void, failure: Failure ) {
//
//        guard let url = URL(string: url) else {
//            return failure(ErrorCase.irrecoverable)
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
//
//            guard
//                let data = data,
//                let obj = try? JSONDecoder().decode(T.self, from: data)
//                else {
//                    return success(nil)
//            }
//            success(obj)
//        }
//        task.resume()
//    }
    
    let baseUrl = "https://newsapi.org"
    
    func fetch<T: Codable>(withRequest request: Request, model: T, success: @escaping Success, failure: @escaping Failure) {
        
        var fullUrlString: String = request.path
        if !fullUrlString.contains(baseUrl){
            fullUrlString = "\(baseUrl)\(fullUrlString)"
        }
        
        guard var fullUrl = URL.init(string: fullUrlString) else {
            failure(ErrorCase.irrecoverable)
            return
        }
        
        var urlRequest = URLRequest(url: fullUrl)
        
        urlRequest.httpMethod = request.method.rawValue
        
        switch request.method {
        case .get:
            // For GET Only
            for queryParameter in request.parameters ?? [:] {
                fullUrlString += "\(queryParameter.key)=\(queryParameter.value)&"
            }
            fullUrlString.removeLast()
            fullUrl = URL(string: fullUrlString) ?? fullUrl
            urlRequest.url = fullUrl
            
        default:
            // For POST and other methods
            urlRequest.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: request.parameters ?? [:], options: []) else {
                return
            }
            urlRequest.httpBody = httpBody
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode,
                error == nil,
                let obj = try? JSONDecoder().decode(T.self, from: data)
                else {
                    return failure(ErrorCase.irrecoverable)
            }
            success(obj)
        }
        task.resume()
    }
    
}

