//
//  NewsModel.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/18/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

struct NewsModel: Codable {
    var status: String?
    var totalResults: Int? = 0
    var articles: [Article]?
}

struct Article: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    var source: Source?
}

struct Source: Codable {
    var id: String?
    var name: String?
}
