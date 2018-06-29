//
//  CurrenciesApi.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 28.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

protocol GetCurrenciesApi {
    func getCurrencies(model: CurrenciesRequstModel, result: @escaping (Response<CurrenciesModel>) -> Void)
}

final class CurrencyApi: BaseApi<CurrenciesModel>, GetCurrenciesApi {
    func getCurrencies(model: CurrenciesRequstModel, result: @escaping (Response<CurrenciesModel>) -> Void) {
        super.call(with: model.request) { (response) in
            result(response)
        }
    }
}
