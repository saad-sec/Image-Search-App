//
//  ImageModel.swift
//  FlickrSearch
//
//  Created by Saad on 21/1/22.
//

import UIKit

struct ImageModel {

    let imageURL: String
    
    init(withPhotos photo: FPhoto) {
        imageURL = photo.imageURL
    }
}

struct MainImageModel {

    let thumbImageURL: String
    let mainImageURL: String
    let title: String
    
    init(withPhotos photo: FPhoto) {
        thumbImageURL = photo.imageURL
        mainImageURL = photo.mainImageURL
        title = photo.title
    }
}
