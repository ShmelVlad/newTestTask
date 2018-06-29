//
//  CurrenciesCell.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation
import UIKit

class CurrenciesCell: UITableViewCell {
    private var data: Currency!
    
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var name: UILabel!
    
    func bind(data: Currency) {
        self.data = data
        
        name.text = data.name
        volume.text = "\(data.volume)"
        amount.text = String.init(format: "%.2f", data.price.amount)
    }
    
    func getInfo() -> Currency {
        return data
    }
}
