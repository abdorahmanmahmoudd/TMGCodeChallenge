//
//  NewsCoordinator.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/19/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import UIKit

final class NewsCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var newsViewController: NewsViewController?
    private var articleDetailsCoordinator: ArticleDetailsCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    func start() {
        
        if let vc = self.createViewController(withStoryboardName: Storyboard.News.rawValue,
                                              andViewControllerID: ViewController.NewsViewController.rawValue) as? NewsViewController {
            
            let viewModel = NewsViewModel()
            vc.newsViewModel = viewModel
            viewModel.coordiantorDelegate = self
            self.newsViewController = vc
            
            presenter.pushViewController(vc, animated: true)
        }
        
    }
}

extension NewsCoordinator: NewsViewModelDelegate {
    func didSelectArticle(_ selectedArticle: Article) {
        let articleDetailsCoordinator = ArticleDetailsCoordinator.init(presenter: presenter, article: selectedArticle)
        articleDetailsCoordinator.start()
        self.articleDetailsCoordinator = articleDetailsCoordinator
    }
}
