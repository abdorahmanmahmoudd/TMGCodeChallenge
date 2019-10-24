//
//  NewsTableViewCellViewModel.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/18/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

class NewsCellViewModel {
    
    var title: String
    var content: String
    
    init(article: Article) {
        
        self.title = article.title ?? ""
        self.content = article.content ?? ""
    }
}
