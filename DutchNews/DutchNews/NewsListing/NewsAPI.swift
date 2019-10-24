//
//  API.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/18/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

//extension APIClient {
//    func fetchNews(withCountry country: String, andPageIndex pageIndex: Int, success: @escaping NewsSuccess, failure: @escaping Failure) {
//        apiProvider.fetchNews(withCountry: country, andPageIndex: pageIndex, success: success, failure: failure)
//    }
//}

//typealias NewsSuccess = (NewsModel?) -> Void

//extension RealAPI {

//    func fetchNews(withCountry country: String, andPageIndex pageIndex: Int, success: @escaping NewsSuccess, failure: @escaping Failure) {
//        // we can use Keychain pod to store the api key into the keychain as it should be secure.
//        let apiURLString = "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=\(apiKey)&page=\(pageIndex)"
//        fetch(url: apiURLString, success: success, failure: failure)
//    }
    

//}

class NewsAPI {
    
    private var apiClient: APIClient
    
    init(apiProvider: API = RealAPI()) {
        self.apiClient = APIClient(apiProvider: apiProvider)
    }
    
    func fetchNews(withCountry country: String, andPageIndex pageIndex: Int, success: @escaping Success, failure: @escaping Failure) {
        
        let fetchNewsRequest = NewsRequest.fetchNews(country: country, apiKey: Constants.apiKey.rawValue, pageIndex: pageIndex)
        
        apiClient.apiProvider.fetch(withRequest: fetchNewsRequest, model: NewsModel(), success: { data in
            success(data)
        }, failure: { error in
            failure(error)
        })
    }
}


