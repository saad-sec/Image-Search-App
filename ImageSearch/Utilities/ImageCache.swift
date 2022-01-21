//
//  ImageCache.swift
//  FlickrSearch
//
//  Created by Saad on 21/1/22.
//

import Foundation
import UIKit

class ImageCache: NSObject{
    
    static let shared = ImageCache()
    
    private var cache: NSCache<AnyObject, AnyObject> = NSCache()
    
    func saveImageToCache(cacheKey: String, image: UIImage) {
        self.cache.setObject(image, forKey: cacheKey as AnyObject)
    }
    
    func loadImageFromCache(cacheKey: String) -> UIImage? {
        if (self.cache.object(forKey: cacheKey as AnyObject) != nil) {
            return self.cache.object(forKey: cacheKey as AnyObject) as? UIImage
        } else {
            return nil
        }
    }
}
