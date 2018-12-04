//
//  Bindable.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation

protocol Bindable {
    associatedtype DataType
    
    func getCount() -> Int
    func appendItems(_ items: [DataType])
    func item(index: Int) -> DataType
}
