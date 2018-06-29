//
//  CurrencyUseCase.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

class CurrencyUseCase: Interactor {
    private var mainThreadExecutor: MainThreadExecutor
    private var backgroundThreadExecutor: BackgroundThreadExecutor
    private var api: GetCurrenciesApi
    
    var callback: ((Response<CurrenciesModel>) -> Void)?
    
    init(api: GetCurrenciesApi, mainThreadExecutor: MainThreadExecutor, backgroundThreadExecutor: BackgroundThreadExecutor) {
        self.api = api
        self.mainThreadExecutor = mainThreadExecutor
        self.backgroundThreadExecutor = backgroundThreadExecutor
    }
    
    func run() {
        api.getCurrencies(model: CurrenciesRequstModel.getСurrencies()) { [weak self] (result) in
            self?.mainThreadExecutor.execute {
                self?.callback?(result)
            }
        }
    }
    
    func execute(callback:@escaping (Response<CurrenciesModel>) -> Void) {
        self.callback = callback
        backgroundThreadExecutor.execute(usecase: self)
        
    }
    
}
