//
//  CurrenciesApi.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 28.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

protocol GetNewsApi {
    func getNews(model: NewsRequstModel, result: @escaping (Response<ListNews>) -> Void)
}

final class NewsApi: BaseApi<ListNews>, GetNewsApi {
    func getNews(model: NewsRequstModel, result: @escaping (Response<ListNews>) -> Void) {
        super.call(with: model.request) { (response) in
            result(response)
        }
    }
}
