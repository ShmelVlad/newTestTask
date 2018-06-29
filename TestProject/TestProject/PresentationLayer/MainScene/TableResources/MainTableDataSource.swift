//
//  MainDataSource.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation
import UIKit

class MainTableDS<Cell: Configuratable, D: Bindable>: NSObject, UITableViewDataSource where Cell.DataType == D.DataType {
    
    private var tableData:D!
    
    func setupData(data:D) {
        tableData = data
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.getId()) as! Cell.CellType
        Cell.configurate(cell: cell, data: tableData.item(index: indexPath.row))
        return cell
    }
}
