//
//  FPhoto.swift
//  FlickrSearch
//
//  Created by Saad on 21/1/22.
//

import Foundation

struct FPhoto: Codable {
    
    let farm : Int
    let id : String
    
    let isfamily : Int
    let isfriend : Int
    let ispublic : Int
    
    let owner: String
    let secret : String
    let server : String
    let title: String
    
    var imageURL: String {
        let urlString = String(format: ImageSearchConstants.imageURL, farm, server, id, secret)
        return urlString
    }
}
