//
//  CellConfigurator.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

class CurrenciesCellConfigurator: NSObject, Configuratable {
    
    typealias DataType = Currency
    
    typealias CellType = CurrenciesCell
    
    static func getId() -> String {
        return "testCurrency"
    }
    
    static func configurate(cell: CurrenciesCell, data: Currency) {
        cell.bind(data: data)
    }
    
    
}
