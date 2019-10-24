//
//  NewsViewModel.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/18/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum NewsTableViewCellType {
    case normal(cellViewModel: NewsCellViewModel)
    case error(message: String)
    case empty
}

protocol NewsViewModelDelegate: class {
    func didSelectArticle(_ selectedArticle: Article)
}

class NewsViewModel {
    
    let cells = BehaviorRelay<[NewsTableViewCellType]>(value: [])
    private let disposeBag = DisposeBag()
//    private let apiClient: APIClient
    private let newsUseCaseManager: NewsAPI
    let showLoadingIndicator = BehaviorRelay(value: false)
    let stopRefreshing = BehaviorRelay(value: false)
    
    private var articles: [Article] = []
    private let pageSize = 20
    private var pageIndex = 1
    private var totalItems = 0
    
    weak var coordiantorDelegate: NewsViewModelDelegate?

    init(apiProvider: API = RealAPI()) {
        newsUseCaseManager = NewsAPI(apiProvider: apiProvider)
    }
    
    func fetchNews(withCountry country: String = "nl", andPageIndex pageIndex: Int = 1, andShowLoadingIndicator shouldShowLoadingIndicator: Bool = true) {
        
        if shouldShowLoadingIndicator {
            showLoadingIndicator.accept(true)
        }
        
        newsUseCaseManager.fetchNews(withCountry: country, andPageIndex: pageIndex, success: { [weak self] response in
            
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.showLoadingIndicator.accept(false)
                self.stopRefreshing.accept(true)
            }
            
            guard let news = response as? NewsModel, (news.articles?.count ?? 0) > 0 else {
                self.cells.accept([.empty])
                return
            }
            
            self.articles.append(contentsOf: news.articles ?? [])
            self.totalItems = news.totalResults ?? 0
            
            let articlesCells = self.articles.compactMap({ (article) -> NewsTableViewCellType in
                .normal(cellViewModel: NewsCellViewModel(article: article))
            })
            self.cells.accept(articlesCells)
            
            
            
        }) { [weak self] (error) in
            
            print(error?.localizedDescription ?? "error in fetchNews(withCountry:)")
            DispatchQueue.main.async {
                self?.showLoadingIndicator.accept(false)
                self?.stopRefreshing.accept(true)
            }
            let message = getErrorMessage(error: error)
            self?.cells.accept([.error(message: message)])
        }
    }
    
    func shouldFetchNextPage(withCellIndex index: Int) -> Bool{
        
        if let lastCell = cells.value.last {
            
            switch lastCell {
            case .normal:
                if index == cells.value.count - 1 {
                    if totalItems > cells.value.count {
                        return true
                    }
                }
            default:
                return false
            }
        }
        return false
    }
    
    func fetchNextPage() {
        self.pageIndex += 1
        self.fetchNews(andPageIndex: self.pageIndex)
    }
    
    func refreshNews() {
        pageIndex = 1
        fetchNews(andPageIndex: pageIndex, andShowLoadingIndicator: false)
        articles.removeAll()
    }
    
    func showArticleDetails(withIndexPath indexPath: IndexPath) {
        let selectedeArticle = articles[indexPath.row]
        coordiantorDelegate?.didSelectArticle(selectedeArticle)
    }
}
