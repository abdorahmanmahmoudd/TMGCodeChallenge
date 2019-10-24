//
//  MockAPIClient.swift
//  DutchNewsTests
//
//  Created by Abdorahman Youssef on 7/19/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation
@testable import DutchNews

final class MockAPI: API {
    
    var expectedResults: Result<NewsModel, ErrorCase>?
    
    func fetch<T: Codable>(withRequest request: Request, model: T, success: @escaping Success, failure: @escaping Failure) {
        
        if request as? NewsRequest != nil{
            fetchNews(success: success, failure: failure)
        }
    }
    
    func fetchNews(success: @escaping Success, failure: @escaping Failure) {
        switch self.expectedResults {
        case .success(let news)?:
            success(news)
        case .failure(let error)?:
            failure(error)
        case .none:
            failure(ErrorCase.irrecoverable)
        }
    }
}
