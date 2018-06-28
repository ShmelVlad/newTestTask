//
//  BaseRequestModel.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 28.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

protocol RequestModel {
    var url: URL {get}
    var data: Data? {get}
    var request: URLRequest {get}
}

enum CurrenciesRequstModel {
    case getСurrencies()
}

extension CurrenciesRequstModel: RequestModel {
    
    var url: URL {
        switch  self {
            case .getСurrencies():
                return URL(string: "http://phisix-api3.appspot.com/stocks.json")!
        }
    }
    
    var data: Data? {
        switch self {
            case .getСurrencies():
                return nil
        }
    }
    
    var request: URLRequest {
        switch self {
            case .getСurrencies():
                let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
                return request
        }
    }
    
    
}
