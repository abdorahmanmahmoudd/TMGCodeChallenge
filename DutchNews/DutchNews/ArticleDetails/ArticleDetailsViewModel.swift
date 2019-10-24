//
//  ArticleDetailsViewModel.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/19/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation
import RxCocoa

class ArticleDetailsViewModel {
    
    var article = BehaviorRelay<Article>(value: Article())
    
    init(article: inout Article) {
        let formattedDateString = getFormattedDateString(ofDateString: article.publishedAt ?? "")
        article.publishedAt = formattedDateString
        self.article.accept(article)
    }
    
    func getFormattedDateString(ofDateString dateString: String) -> String {
        var dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ" //2019-07-17T21:03:00Z
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat
        if let date = dateFormatter.date(from: dateString) {
            dateFormat = "yyyy-MM-dd hh:mm:ss"
            dateFormatter.dateFormat = dateFormat
            return dateFormatter.string(from: date)
        }else {
            return "Published at: -"
        }
    }
}
