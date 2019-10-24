//
//  NewsTableViewCell.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/18/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import UIKit
import RxSwift

class NewsTableViewCell: UITableViewCell {
    
    static let reusableIdentifier = "NewsTableViewCell"

    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var containerView: UIView!
    
    private let disposeBag = DisposeBag()
    
    private var viewModel: NewsCellViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 6
    }
  
    private func bindViewModel() {
        
        if let viewModel = viewModel {
            titleLabel.text = viewModel.title
            contentLabel.text = viewModel.content
        }
    }
    
    func configureCell(withViewModel viewModel: NewsCellViewModel) {
        self.viewModel = viewModel
    }

    
}
