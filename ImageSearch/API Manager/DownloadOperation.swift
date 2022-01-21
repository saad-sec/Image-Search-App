//
//  ImageDownloadOperation.swift
//  ImageSearch
//
//  Created by Saad on 21/1/22.
//

import UIKit

typealias ImageCompletion = (_ image : UIImage?, _ url : String) -> Void

class DownloadOperation: Operation {
    
    let url: String?
    var customCompletionBlock: ImageCompletion?
    
    init(url: String, completionBlock: @escaping ImageCompletion) {
        self.url = url
        self.customCompletionBlock = completionBlock
    }
    
    override func main() {
        
        if self.isCancelled { return }
        
        if let url = self.url {
        
            if self.isCancelled { return }
            
            APIManager.shared.downloadImage(url) { (result) in
            
                DispatchQueue.main.async {
                    switch result {
                    case .Success(let image):
                        if self.isCancelled { return }
                        if let completion = self.customCompletionBlock{
                            completion(image, url)
                        }
                    default:
                        if self.isCancelled { return }
                        break
                    }
                }
                
            }
        }
    }
}

