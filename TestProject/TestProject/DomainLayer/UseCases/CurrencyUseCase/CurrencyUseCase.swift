//
//  CurrencyUseCase.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

class NewsUseCase: Interactor {
    private var _mainThreadExecutor: MainThreadExecutor
    private var _backgroundThreadExecutor: BackgroundThreadExecutor
    private var _api: GetNewsApi
    
    private var _callback: ((Response<ListNews>) -> Void)?
    private var _page: Int!
    
    init(api: GetNewsApi, mainThreadExecutor: MainThreadExecutor, backgroundThreadExecutor: BackgroundThreadExecutor) {
        _api = api
        _mainThreadExecutor = mainThreadExecutor
        _backgroundThreadExecutor = backgroundThreadExecutor
    }
    
    func run() {
        _api.getNews(model: .getNews(page: _page)) { [weak self] (result) in
            self?._mainThreadExecutor.execute {
                self?._callback?(result)
            }
        }
    }
    
    func execute(page: Int, callback:@escaping (Response<ListNews>) -> Void) {
        _callback = callback
        _page = page
        _backgroundThreadExecutor.execute(usecase: self)
        
    }
    
}
