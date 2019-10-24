//
//  ArticleDetailsCoordinator.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/19/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import UIKit

final class ArticleDetailsCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var articleDetailsViewController: ArticleDetailsViewController?
    private var article: Article
    
    init(presenter: UINavigationController, article: Article) {
        self.presenter = presenter
        self.article = article
    }
    
    func start() {
        if let vc = createViewController(withStoryboardName: Storyboard.ArticleDetails.rawValue,
                                         andViewControllerID: ViewController.ArticleDetailsViewController.rawValue) as? ArticleDetailsViewController {
        
            let viewModel = ArticleDetailsViewModel(article: &self.article)
            vc.articleDetailsViewModel = viewModel
            presenter.pushViewController(vc, animated: true)
            self.articleDetailsViewController = vc
        }
    }
}
