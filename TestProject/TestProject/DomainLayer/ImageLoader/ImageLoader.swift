//
//  ImageLoader.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 21.11.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation
import UIKit.UIImage

protocol ImageLoader: class {
    var cache: NSCache<News, UIImage> { get }
    func stopLoadingImage(for news: News)
    func startLoadingImg(for news: News, complete:@escaping (UIImage?)->())
}
