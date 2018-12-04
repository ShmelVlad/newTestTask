//
//  ImageLoader.swift
//  TestProject
//
//  Created by Vladislav Shmelev on 21.11.2018.
//  Copyright © 2018 123. All rights reserved.
//

import Foundation
import UIKit.UIImage

final class ImageLoaderService: ImageLoader {
    
    var cache: NSCache<News, UIImage> = NSCache()
    
    private lazy var _queue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "LoadImg.queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    func stopLoadingImage(for news: News) {

        for oper in _queue.operations as! [ImageOperation] {
            if news.images.count == 0 || oper.data.images.count == 0 {
                continue
            }
            if oper.data.images[0].image == news.images[0].image {
                oper.cancel()
            }
        }
    }
    
    func startLoadingImg(for news: News, complete:@escaping (UIImage?)->()) {
        if news.image != nil { return }
        let oper = ImageOperation(data: news)
        
        oper.completionBlock = { [unowned self] in
            if oper.isCancelled {
                return
            }
            DispatchQueue.main.async {
                complete(news.image)
            }
        }
        _queue.addOperation(oper)
    }
    
    
}

class ImageOperation: Operation {
    var data: News
    init(data: News) {
        self.data = data
    }
    
    override func main() {
        if isCancelled {
            return
        }

        if data.images.count == 0 {
            self.cancel()
            return
        }
        let url = URL(string: data.images[0].image)!
        guard let imageData = try? Data(contentsOf: url) else {
            return
        }
        let img = Utils.resizeImage(image: UIImage(data: imageData)!, targetSize: CGSize(width: 500, height: 500))
        data.image = img
    }
}

class Utils {
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
