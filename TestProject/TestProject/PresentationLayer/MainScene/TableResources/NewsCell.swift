//
//  CurrenciesCell.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 29.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation
import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet private weak var newsImage: UIImageView!
    @IBOutlet private weak var shortText: UILabel!
    @IBOutlet private weak var dateLbl: UILabel!
    @IBOutlet private weak var likes: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func bind(data: News) {
        shortText.text = data.title
        dateLbl.text = data.published
        likes.text = "Likes: \(data.likes)"
        if data.image == nil {
        } else {
            newsImage.image = data.image
        }
    }
    
    func clear() {
        newsImage.image = nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likes.text = nil
        imageView?.image = nil
    }
}
