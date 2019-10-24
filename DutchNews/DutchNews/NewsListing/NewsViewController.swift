//
//  NewsViewController.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/18/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PKHUD

class NewsViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var newsTableView: UITableView!
    let refreshControl: UIRefreshControl = UIRefreshControl()
    var newsViewModel: NewsViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
        newsViewModel?.fetchNews()
    }

    func setupViews() {
        title = NSLocalizedString("NewsTitle", comment: "")
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        setupTableView()
    }
    
    func setupTableView() {
        let newsTableViewNib = UINib.init(nibName: NewsTableViewCell.reusableIdentifier, bundle: nil)
        newsTableView.register(newsTableViewNib, forCellReuseIdentifier: NewsTableViewCell.reusableIdentifier)
        newsTableView.tableFooterView = UIView()
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.estimatedRowHeight = 100
        newsTableView.refreshControl = refreshControl
        newsTableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func bindViewModel(){
        setupPagination()
        setupTableViewCellSelection()
        bindNewsTableView()
        bindLoadingIndicator()
        bindRefreshControl()
    }
    
    func setupPagination() {
        newsTableView.rx
            .willDisplayCell
            .subscribe(onNext: { [weak self] cell, indexPath in
                if self?.newsViewModel?.shouldFetchNextPage(withCellIndex: indexPath.row) ?? false {
                    self?.newsViewModel?.fetchNextPage()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setupTableViewCellSelection() {
        newsTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                
                self?.newsViewModel?.showArticleDetails(withIndexPath: indexPath)
                
            }).disposed(by: disposeBag)
    }
    
    func bindNewsTableView() {
        
        newsViewModel?.cells.bind(to: newsTableView.rx.items) { [weak self] (tableView, index, element) in
            
            let indexPath = IndexPath(item: index, section: 0)
            
            switch element {
                
            case .normal(let viewModel):
                
                guard let cell = self?.newsTableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reusableIdentifier, for: indexPath) as? NewsTableViewCell else {
                    return UITableViewCell()
                }
                cell.configureCell(withViewModel: viewModel)
                return cell
                
            case .error(let message):
                
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = message
                cell.textLabel?.textAlignment = .center
                return cell
                
            case .empty:
                
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = NSLocalizedString("NewsEmptyResult", comment: "")
                cell.textLabel?.textAlignment = .center
                return cell
            }
            }.disposed(by: disposeBag)
    }
    
    func bindLoadingIndicator() {
        newsViewModel?.showLoadingIndicator.asObservable().distinctUntilChanged()
            .map { [weak self] in
                self?.setLoadingIndicator(visible: $0)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    
    func bindRefreshControl() {
        newsViewModel?.stopRefreshing.asObservable()
            .map { [weak self] _ in
                self?.stopRefreshControl()
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func setLoadingIndicator(visible: Bool) {
        PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
        visible ? PKHUD.sharedHUD.show(onView: view) : PKHUD.sharedHUD.hide()
    }
    
    private func stopRefreshControl() {
        self.refreshControl.endRefreshing()
    }
    
    @objc func refreshNews() {
        newsViewModel?.refreshNews()
    }

}

