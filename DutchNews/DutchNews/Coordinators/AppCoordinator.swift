//
//  AppCoordinator.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/19/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    let window: UIWindow
    let rootViewController: UINavigationController?
    let newsCoordinator: NewsCoordinator
    
    init(window: UIWindow) {
        
        self.window = window
        let navigationController = UINavigationController()
        rootViewController = navigationController
        
        newsCoordinator = NewsCoordinator(presenter: navigationController)
        newsCoordinator.start()
        
        setupNavigationController()
    }
    
    func start() {
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func setupNavigationController() {
        rootViewController?.navigationBar.barTintColor = UIColor.white
        rootViewController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        rootViewController?.navigationBar.barStyle = .default
    }
}
