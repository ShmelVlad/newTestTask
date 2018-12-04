//
//  CellConfigurator.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

class NewsCellConfigurator: NSObject, Configuratable {
    
    typealias DataType = News
    
    typealias CellType = NewsCell
    
    static func getId() -> String {
        return "news"
    }
    
    static func configurate(cell: NewsCell, data: News) {
        cell.bind(data: data)
    }
    
    static func clear(cell: NewsCell) {
        cell.clear()
    }
}
