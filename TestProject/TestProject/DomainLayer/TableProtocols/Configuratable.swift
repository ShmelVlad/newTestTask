//
//  Configuratable.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation
import UIKit

protocol Configuratable {
    associatedtype DataType
    associatedtype CellType: UITableViewCell
    
    static func getId() -> String
    static func configurate(cell: CellType, data: DataType)
}
