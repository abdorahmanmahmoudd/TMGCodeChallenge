//
//  Coordinator.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/18/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    func start()
    func createViewController(withStoryboardName storyboardName: String, andViewControllerID vcID: String) -> UIViewController?
}

extension Coordinator {
    
    func createViewController(withStoryboardName storyboardName: String, andViewControllerID vcID: String) -> UIViewController? {
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: vcID)
        return vc
    }
}
