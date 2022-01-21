//
//  DownloadManager.swift
//  ImageSearch
//
//  Created by Saad on 21/1/22.
//

import UIKit

typealias ImageClosure = (_ result: Result<UIImage>, _ url: String) -> Void

class DownloadManager: NSObject {
    
    static let shared = DownloadManager()
    
    private var operationQueue = OperationQueue()
    private var dictionaryBlocks = [UIImageView: (String, ImageClosure, DownloadOperation)]()
    
    private override init() {
        operationQueue.maxConcurrentOperationCount = 100
    }
    
    func addOperation(url: String, imageView: UIImageView, completion: @escaping ImageClosure) {
        
        if let image = ImageCache.shared.loadImageFromCache(cacheKey: url)  {
            
            completion(.Success(image), url)
            if let tupple = self.dictionaryBlocks.removeValue(forKey: imageView){
                tupple.2.cancel()
            }
            
        } else {
            
            if !checkOperationExists(with: url,completion: completion) {
            
                if let tupple = self.dictionaryBlocks.removeValue(forKey: imageView){
                    tupple.2.cancel()
                }
                
                let newOperation = DownloadOperation(url: url) { (image,downloadedImageURL) in
                
                    if let tupple = self.dictionaryBlocks[imageView] {
                    
                        if tupple.0 == downloadedImageURL {
                        
                            if let image = image {
                            
                                ImageCache.shared.saveImageToCache(cacheKey: downloadedImageURL, image: image)
                                tupple.1(.Success(image), downloadedImageURL)
                                
                                if let tupple = self.dictionaryBlocks.removeValue(forKey: imageView){
                                    tupple.2.cancel()
                                }
                                
                            } else {
                                tupple.1(.Failure("Not fetched"), downloadedImageURL)
                            }
                            
                            _ = self.dictionaryBlocks.removeValue(forKey: imageView)
                        }
                    }
                }
                
                dictionaryBlocks[imageView] = (url, completion, newOperation)
                operationQueue.addOperation(newOperation)
            }
        }
    }
    
    func checkOperationExists(with url: String, completion: @escaping ImageClosure) -> Bool {
        
        if let arrayOperation = operationQueue.operations as? [DownloadOperation] {
            let opeartions = arrayOperation.filter{$0.url == url}
            return opeartions.count > 0 ? true : false
        }
        
        return false
    }
}
