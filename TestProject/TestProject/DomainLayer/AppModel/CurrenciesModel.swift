//
//  CurrenciesModel.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 28.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

struct CurrenciesModel: Decodable {
    var stock: [Currency]
}

struct Currency: Decodable {
    var name: String
    var price: PriceModel
}

struct PriceModel: Decodable {
    var currency: String
    var amount: Double
}
