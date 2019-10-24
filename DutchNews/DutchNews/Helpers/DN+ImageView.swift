//
//  DN+ImageView.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/19/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    fileprivate var activityIndicator: UIActivityIndicatorView {
        if let activityIndicator = subviews.compactMap({ $0 as? UIActivityIndicatorView }).first {
            return activityIndicator
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .white)
        addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        return activityIndicator
    }
    
    fileprivate func startLoading() {
        activityIndicator.startAnimating()
    }
    
    fileprivate func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func setImage(_ imageURLString: String) {
        let placeholder = UIImage(named: "placeholder")
        guard let imageURL = URL(string: imageURLString) else {
            image = placeholder
            return
        }
        startLoading()
        self.kf.setImage(with: imageURL, placeholder: nil, options: nil, progressBlock: nil, completionHandler: {
            [weak self] _, _, _, _ in
            self?.stopLoading()
        })
        
        
    }
}

