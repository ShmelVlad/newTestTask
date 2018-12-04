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

enum NewsRequstModel {
    case getNews(page: Int)
}

extension NewsRequstModel: RequestModel {
    
    var url: URL {
        switch  self {
            case .getNews(let page):
                return URL(string: "http://api.flatun.com/api/feed_item/?page=\(page)")!
        }
    }
    
    var data: Data? {
        switch self {
            case .getNews(_):
                return nil
        }
    }
    
    var request: URLRequest {
        switch self {
            case .getNews(_):
                let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
                return request
        }
    }
    
    
}
