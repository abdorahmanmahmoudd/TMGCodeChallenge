//
//  ModelTest.swift
//  DutchNewsTests
//
//  Created by Abdorahman Youssef on 7/19/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import XCTest
@testable import DutchNews

typealias JSON = Dictionary<String, Any>

class ModelTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNewsSuccessfulInitialization() {
        
        let sourceJson: JSON = ["id": "1", "name": "Abdo" ]
        
        let articleJSON: JSON = ["title": "Zeer grote brand bij papierrecyclingbedrijf in Staphorst - RTV Oost",
                                        "author": "RTV Oost",
                                        "description": "Bij een papierrecyclingbedrijf aan de Industrieweg in Staphorst woedt een zeer grote brand. Een deel van het gebouw is ingestort, volgens de brandweer moet het gebouw van Huhtamaki Paper Recycling als verloren worden beschouwd. Een deel van het fabriekspand s…",
                                        "url": "https://www.rtvoost.nl/nieuws/315856/Zeer-grote-brand-bij-papierrecyclingbedrijf-in-Staphorst",
                                        "urlToImage": "https://imgo.rgcdn.nl/e297fdd8507a405fa5c263cd056fc567/opener/Zeer-grote-brand-bij-papierrecyclingbedrijf-in-Staphorst-Foto-De-Vries-Media.jpg?v=mZxRb3ZzON_MBFUKmq9Pqg2",
                                        "publishedAt": "2019-07-17T23:00:06Z",
                                        "content": "Een deel van het fabriekspand stortte een uur na de eerste melding van de brand al in: een buitenmuur en een deel van het dak stortten naar beneden. \r\nOmstanders zeggen verschillende explosies tijdens de brand te hebben gehoord. \r\nBrandweerkorpsen uit verschi… [+816 chars]",
                                        "source": sourceJson]
        let articles = Article(json: articleJSON)
        XCTAssertNotNil(articles)
        
        let newsJson = ["status" : "ok",
                        "totalResults": 34,
                        "articles": [articleJSON] ] as [String : Any]

        let news = NewsModel.init(json: newsJson)
        
        XCTAssertNotNil(news)
    }
    
}

private extension NewsModel {
    
    init?(json: JSON) {
        
        guard let status = json["status"] as? String,
            let totalResults = json["totalResults"] as? Int,
            let articlesJson = json["articles"] as? [JSON] else {
                return nil
        }
        
        self.init(status: status, totalResults: totalResults, articles: [])
        
        self.articles = []
        for obj in articlesJson {
            if let article = Article.init(json: obj) {
                self.articles?.append(article)
            }
        }
        
        
    }
}

private extension Article {
    
    init?(json: JSON) {
        guard let author = json["author"] as? String,
            let title = json["title"] as? String,
            let description = json["description"] as? String,
            let url = json["url"] as? String,
            let urlToImage = json["urlToImage"] as? String,
            let publishedAt = json["publishedAt"] as? String,
            let content = json["content"] as? String,
            let sourceObject = json["source"] as? JSON,
            let source = Source.init(json: sourceObject) else {
                return nil
        }
        
        self.init(author: author, title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt, content: content, source: source)
    }
}

private extension Source{
    init?(json: JSON) {
        guard let id = json["id"] as? String,
            let name = json["name"] as? String else {
                return nil
        }
        
        self.init(id: id, name: name)
    }
}
