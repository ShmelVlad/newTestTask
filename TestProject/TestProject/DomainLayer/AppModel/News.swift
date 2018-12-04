//
//  CurrenciesModel.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 28.06.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation
import UIKit.UIImage

class ListNews: Decodable, Bindable {
    
    typealias DataType = News
    
    var results: [News]
    var next: String?
    
    init(news: [News]) {
        results = news
    }
    
    func getCount() -> Int {
        return results.count
    }
    
    func item(index: Int) -> News {
        return results[index]
    }
    
    func appendItems(_ items: [News]) {
        results += items
    }
}

class News: Decodable {
    var title: String
    var published: String
    var images: [Image]
    var likes: Int
    var image: UIImage?
    
    private enum NewsKeys: String, CodingKey {
        case title
        case published
        case images
        case likes = "likes_count"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: NewsKeys.self)
        title = try container.decode(String.self, forKey: .title)
        let dateStr = try container.decode(String.self, forKey: .published)
        
        let fmt = DateFormatter()
        fmt.dateFormat = "YYYY-MM-dd'T'HH:mm:ssZ"
        
        if let date = fmt.date(from: dateStr) {
            fmt.dateFormat = "dd MMM HH:mm:ss"
            published = fmt.string(from: date)
        } else {
            published = ""
        }
        
        likes = try container.decode(Int.self, forKey: .likes)
        images = try container.decode([Image].self, forKey: .images)
        
    }
    
    
}

class Image: Decodable {
    var image: String
}
