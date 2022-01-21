
//
//  Request.swift
//  ImageSearch
//
//  Created by Saad on 21/1/22.
//

import UIKit

enum HttpMethod: String {
    case get    = "GET"
    case post   = "POST"
    
    var value: String {
        return self.rawValue
    }
}

class Request: NSMutableURLRequest {
    
    convenience init?(httpMethod: HttpMethod, urlString: String, bodyParams: [String: Any]? = nil) {
        
        guard let url =  URL.init(string: urlString) else {
            return nil
        }
        
        self.init(url: url)
        
        do {
            if let bodyParams = bodyParams {
                let data = try JSONSerialization.data(withJSONObject: bodyParams, options: .prettyPrinted)
                self.httpBody = data
            }
        } catch {
            
        }
        
        self.httpMethod = httpMethod.value
        
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
