//
//  ArticleDetailsViewController.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/18/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import UIKit
import RxSwift

class ArticleDetailsViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var sourceLabel: UILabel!
    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var articleDate: UILabel!
    @IBOutlet var articleContent: UILabel!
    @IBOutlet var articleAuthor: UILabel!
    
    var articleDetailsViewModel: ArticleDetailsViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        
        articleDetailsViewModel?.article.subscribe(onNext: { [weak self] (article) in
            
            guard let self = self else {
                return
            }
            
            self.titleLabel.text = article.title ?? "title: -"
            self.sourceLabel.text = article.source?.name ?? "source: -"
            self.articleDate.text = article.publishedAt
            self.articleContent.text = article.content ?? "cotent: -"
            self.articleAuthor.text = article.author ?? "author: -"
            self.articleImageView.setImage(article.urlToImage ?? "")
            
        }).disposed(by: disposeBag)
        
    }

}
