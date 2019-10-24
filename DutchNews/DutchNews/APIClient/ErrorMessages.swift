//
//  ErrorMessages.swift
//  DutchNews
//
//  Created by Abdorahman Youssef on 7/18/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import Foundation

enum ErrorCase: Error {
    case noInternetConnection
    case notFound
    case internalServerError
    case forbidden
    case timeOut
    case irrecoverable
    case notAuthorized
    case badRequest
}


enum ErrorCode: Int {
    case timeOut = 504
    case irrecoverable = 999
    case forbidden = 403
    case internalServerError = 500
    case notFound = 404
    case notAuthorized = 401
    case badRequest = 400
}

func getErrorMessage(error: Error?) -> String {
    
    guard let error = error as? ErrorCase else{
        return NSLocalizedString("UnknownError", comment: "")
    }
    
    switch error {
    case .noInternetConnection:
        return NSLocalizedString("NoInternetMessage", comment: "")
    case .notFound:
        return NSLocalizedString("notFound", comment: "")
    case .internalServerError:
        return NSLocalizedString("internalServerError", comment: "")
    case .forbidden:
        return NSLocalizedString("forbidden", comment: "")
    case .timeOut:
        return NSLocalizedString("timeOut", comment: "")
    case .irrecoverable:
        return NSLocalizedString("irrecoverable", comment: "")
    case .notAuthorized:
        return NSLocalizedString("notAuthorized", comment: "")
    case .badRequest:
        return NSLocalizedString("badRequest", comment: "")
    }
}
