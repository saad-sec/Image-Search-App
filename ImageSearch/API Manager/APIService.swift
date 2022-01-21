//
//  APIService.swift
//  ImageSearch
//
//  Created by Saad on 21/1/22.
//

import UIKit

class APIService: NSObject{
    
    /// Flickr API Call using the "flickr.photos.search" method, to retrieve photos based on search text from a given page
    ///
    /// - Parameters:
    ///   - text: search term
    ///   - page: which page
    ///   - completion: completion handler to retrieve result
    func request(_ searchText: String, pageNo: Int, completion: @escaping (Result<Photos?>) -> Void) {
        
        guard let request = makeRequest(searchText: searchText, pageNo: pageNo) else {
            return
        }
        
        APIManager.shared.request(request) { (result) in
            switch result {
            case .Success(let responseData):
                if let model = self.processResponse(responseData) {
                    if let stat = model.stat, stat.uppercased().contains("OK") {
                        return completion(.Success(model.photos))
                    } else {
                        return completion(.Failure(APIManager.errorMessage))
                    }
                } else {
                    return completion(.Failure(APIManager.errorMessage))
                }
            case .Failure(let message):
                return completion(.Failure(message))
            case .Error(let error):
                return completion(.Failure(error))
            }
        }
    }
    
    func processResponse(_ data: Data) -> FlickrPhotoSearchResults? {
        do {
            let responseModel = try JSONDecoder().decode(FlickrPhotoSearchResults.self, from: data)
            return responseModel
            
        } catch {
            print("Data parsing error: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func makeRequest(searchText: String, pageNo: Int)->Request?{
        let urlString = String(format: ImageSearchConstants.searchURL, searchText, pageNo)
        let reqConfig = Request.init(httpMethod: .get, urlString: urlString)
        return reqConfig
    }
}
