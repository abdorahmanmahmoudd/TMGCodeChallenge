//
//  APIMockHelper.swift
//  DutchNewsTests
//
//  Created by Abdorahman Youssef on 7/19/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

@testable import DutchNews

enum Result<T, U: Error> {
    case success(payload: T)
    case failure(U?)
}

enum EmptyResult<U: Error> {
    case success
    case failure(U?)
}
