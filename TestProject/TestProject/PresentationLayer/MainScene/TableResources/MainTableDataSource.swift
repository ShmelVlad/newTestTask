//
//  MainDataSource.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation
import UIKit

class MainTableDS<Cell: Configuratable, D: Bindable>: NSObject, UITableViewDataSource, UITableViewDelegate where Cell.DataType == D.DataType {
    
    private var tableData:D!
    private var _action: (() -> ())?
    private lazy var _imageService: ImageLoader = {
       return ImageLoaderService.init()
    }()
    private var _cellHeights: [IndexPath : CGFloat] = [:]
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return _cellHeights[indexPath] ?? 70.0
    }
    
    func setupData(data: D) {
        tableData = data
    }
    
    func append(elemtens: [D.DataType]) {
        tableData.appendItems(elemtens)
    }
    
    func loadMore(_ action: @escaping () -> ()) {
        _action = action
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.getCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.getId()) as! Cell.CellType
        Cell.clear(cell: cell)
        Cell.configurate(cell: cell, data: tableData.item(index: indexPath.row))
        if indexPath.row == tableData.getCount() - 1 {
            _action?()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let news = tableData.item(index: indexPath.row) as! News
        _imageService.stopLoadingImage(for: news)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        _cellHeights[indexPath] = cell.frame.size.height
        let news = tableData.item(index: indexPath.row) as! News
        _imageService.startLoadingImg(for: news) { [indexPath] (img) in
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
    }
}
