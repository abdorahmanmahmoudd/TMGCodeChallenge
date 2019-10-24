//
//  NewsModelMock.swift
//  DutchNewsTests
//
//  Created by Abdorahman Youssef on 7/19/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

@testable import DutchNews

extension NewsModel {
    static func with(status: String = "ok", totalResults: Int = 34 ,numberOfArticles: Int = 0 ) -> NewsModel {
        
        var articles: [Article] = []
        
        for _ in 0..<numberOfArticles {
            let article = Article.with()
            articles.append(article)
        }
        return NewsModel.init(status: status, totalResults: totalResults, articles: articles)
    }
}

extension Article {
    
    
    static func with(author: String = "RTV Oos", title: String = "Zeer grote brand bij papierrecyclingbedrijf in Staphorst - RTV Oost",
                     description: String = "description...",
                     url: String = "https://www.rtvoost.nl/nieuws/315856/Zeer-grote-brand-bij-papierrecyclingbedrijf-in-Staphorst",
                     urlToImage: String = "https://www.telegraaf.nl/images/1200x630/filters:format(jpeg):quality(80)/cdn-kiosk-api.telegraaf.nl/0358d902-aa24-11e9-b798-02d2fb1aa1d7.jpg",
                     publishedAt: String = "2019-07-19T12:16:32Z",
                     content: String = "content...",
                     source: Source = Source.with()) -> Article {
        
        return Article.init(author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: content, source: source)
    }
}

extension Source {
    
    static func with(id: String = "2", name: String = "Jordi") -> Source {
        return Source.init(id: id, name: name)
    }
}
